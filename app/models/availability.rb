class Availability < ActiveRecord::Base
  validates_numericality_of :day_of_week, :greater_than => 0, :less_than_or_equal_to => 7
  validates_presence_of :from, :allow_nil => false
  validates_presence_of :to, :allow_nil => false
  validates_with DurationValidator, :from => :from, :to => :to

  belongs_to :user

  class << self
    # Returns the Availability instance corresponding to the time and date when
    # these dates overlap. Makes the following overlaps:
    #
    # * The avails should already be pre-sorted to have the same day of week.
    #   If there are avails with days of the week different than the first, they
    #   will not be considered.
    #
    # The algorithm used will find the latest from and the earliest to to get
    # the "innermost" time range, corresponding to the optimum time in which
    # the most users can be accommodated.
    #
    # Returns nil if avails is empty
    def common_overlap(avails, min_duration=0)
      return nil if avails.empty?
      # Make sure we don't overwrite the source of whatever data is being passed in
      temp_avails = avails.dup
      # Arbitrarily choose the first as the standard
      first = temp_avails.first
      temp_avails.reject! {|avail| avail.overlaps_with?(first, min_duration)}
      temp_avails << first # Re-add the first

      #FIXME: is there some AR magic method to do this more efficiently?
      Availability.new(
        :day_of_week => avails.first.day_of_week,
        :from => avails.collect(&:from).max,
        :to => avails.collect(&:to).min
      )
    end
  end

  def duration
    to - from
  end

  #FIXME: verify logic here
  #NOTE: returns false on self comparisons
  def overlaps_with?(other, min_duration=0)
    other != self and day_of_week == other.day_of_week and (from < other.to or other.from < to) and overlap_duration(other) >= min_duration
  end

  # Overlap duration in minutes
  #TODO: verify logic
  def overlap_duration(other)
    # Return 0 if no overlap
    #FIXME: not DRY
    return 0 unless day_of_week == other.day_of_week and (from < other.to or other.from < to)
    # Figure out which starts first, get the innermost 2 times and take the difference
    head_end = (from > other.from) ? from : other.from
    tail_end = (to < other.to) ? to : other.to
    ((tail_end - head_end) / 60).ceil # always round to the next highest integer
  end
end
