class DurationValidator < ActiveModel::Validator
  def initialize(opts={})
    raise ArgumentError, "Must specify :from and :to options" if options[:from].nil? or options[:to].nil?
  end

  def validate(record)
    from = record.attributes[options[:from]]
    to   = record.attributes[options[:to]]
    if from and to and from > to
      errors[:base] << "From field cannot be later than to field."
    end
  end
end
