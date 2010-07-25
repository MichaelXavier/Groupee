Given /^existing ([^\s]+)( for (.*))?:$/ do |type, _, parent, table|
  table.hashes.each do |row|
    ivar = instantiate_ivar_from_story(type, row)
    associate(parent, ivar) if parent
  end
end

Given /^an? existing ([^\s]+)( with (.*))?$/ do |type, with, attrs|
  instantiate_ivar_from_story(type, attrs)
end

def instantiate_ivar_from_story(type, attrs)
  ivar_name, factory = type_and_factory_from_story(type)
  if attrs.is_a? String
    attrs = attrs.to_hash_from_story
  else
    attrs = attrs.inject({}) {|h,(k,v)| h[ToFooFromStory::fix_key(k)] = ToFooFromStory::fix_value(v);h}
  end
  instance_variable_set("@#{ivar_name}", Factory.create(factory, attrs || {}))
  return ivar_name
end

Given /^the ([^\s]+) has an? ([^\s]+)( with (.*))?$/ do |type_1, type_2, with, attr|
  type_2, type_2_factory = type_and_factory_from_story(type_2)
  opts = with.nil? ? {} : attr.to_hash_from_story

  one = instance_variable_get("@#{type_1}")
  one ||= instance_variable_set("@#{type_1}", Factory.build(type_1, opts))

  two = instance_variable_get("@#{type_2}")
  two ||= instance_variable_set("@#{type_2}", Factory.build(type_2_factory, opts))
  
  associate(type_1, type_2)
  
  one.save!
  two.save!
end

def associate(parent, child)
  one = instance_variable_get("@#{parent}")
  two = instance_variable_get("@#{child}")
  
  association, reflection = one.class.reflections.find {|(k,v)| [child.to_sym, child.tableize.to_sym].include?(k)}
  needs_array = reflection.macro.to_s.include?('many')
  if needs_array
    one.send(association) << two
    two.send(parent + "=", one) if reflection.macro == :has_many
  else
    one.send("#{association}=".to_sym, two)
  end  
end

Given /^the ([^\s]+) ([^\s]+) is updated to "([^\s]+)"$/ do |type, attribute, changed|
  instance_variable_get("@#{type.underscore}").update_attributes(attribute.to_sym => changed)
end

When /^the ([^\s]+) is deleted/ do |type|
  object = instance_variable_get("@#{type.underscore}")
  object.destroy
end


When /^I create a ([^\s]+)( with (.*))$/ do |type, with, attr|
  Given "an existing #{type}#{with}"
end

Then /^the ([^\s]+) will have (.*)$/ do |type, attrs|
  attrs.to_hash_from_story.each do |attribute, value|
    instance_variable_get("@#{type}").send(attribute).to_s.should == value
  end
end

# Returns ex. ["order", "in_checkout"] for "Order:in_checkout"
def type_and_factory_from_story(type)
  type, factory = type.split(":")
  type = type.underscore
  factory ||= type.singularize.underscore.to_sym
  
  return type, factory
end

def correct_hash(h)
  h.inject({}) {|res,(k,v)| res.merge(ToFooFromStory::fix_key(k) => ToFooFromStory::fix_value(v))}
end
