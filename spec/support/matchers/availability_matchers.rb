Rspec::Matchers.define :overlap_with do |other|
  match do |actual|
    actual.overlaps_with?(other)
  end
end
