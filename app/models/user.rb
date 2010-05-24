class User < ActiveRecord::Base
  extend Matricizable
  validates_uniqueness_of :studentid, :email
  validates_inclusion_of :gender, :in => %w[ m f ]
  validates_presence_of :first_name, :last_name, :email

  has_many :group_memberships
  has_many :groups, :through => :group_memberships
  has_many :availabilities
  has_and_belongs_to_many :courses

  def full_name
    [self.first_name, self.last_name].join(" ")
  end

  class << self
    # Results in a spreadsheet for analysis with the following format:
    #             funky_kong  candy_kong  diddy_kong
    # funky_kong         0.0         2.7         1.6
    # candy_kong         2.7         0.0         2.7
    # diddy_kong         1.6         2.7         0.0
    def one_mode_matricize(filename)
      links = Link.includes(:left_user, :right_user)
      users = links.inject([]) {|a, link| a += [link.left_user, link.right_user]}.uniq
      cols_with_keys = users.inject({}) {|h, user| h.merge(user.id => "#{user.full_name}(#{user.id})")}

      workbook = matricize_with_cols(cols_with_keys) do |matrix|
        links.each do |link|
          # Add whatever the weight value is to the left/right participants
          matrix.add_weight(link.left_user_id, link.right_user_id, link.link_type.weight)
        end
      end

      workbook.write(filename)
    end
  end
end
