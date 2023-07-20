class Track < ApplicationRecord
  belongs_to :album, counter_cache: true
  has_many :listenings, dependent: :destroy, inverse_of: :track

  validates :title, length: {maximum: 255}

  after_create do
    Artist.increment_counter(:tracks_count, album.artist_id) # rubocop:disable Rails/SkipsModelValidations
  end

  after_destroy do
    Artist.decrement_counter(:tracks_count, album.artist_id) # rubocop:disable Rails/SkipsModelValidations
  end

  scope :ordered, -> { order(position: :asc) }
  scope :popularity_ordered, -> { order(listenings_count: :desc) }
end
