class DurationValidator < ActiveModel::Validator
  def validate(record)
    from = record.attributes[options[:from].to_s]
    to   = record.attributes[options[:to].to_s]
    if from and to and from > to
      record.errors[:base] << "From field cannot be later than to field."
    end
  end
end
