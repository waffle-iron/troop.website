class Event < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :start, presence: true
  validates :category, presence: true
  
  enum category: [:troop_meeting, :campout, :outing, :plc, :committee_meeting, 
                    :service_project, :training, :other]

  has_many :scout_events
  has_many :scouts, through: :scout_events

  scope :events_in_60_day_window, -> {where('events.start between ? and ?', 30.days.ago, 30.days.from_now) }
  # scope :today, -> { where(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }


  def self.search(search)
    if search
      #search by id
      #where('category LIKE ?', "%#{search}%")
      #seach exact match
      where(category: Event.categories[search.parameterize.underscore.to_sym])
    else
      all
    end
  end

  def self.to_csv(report)
    CSV.generate(headers: true) do |csv|
      case report
        when 'troopCalendar'
          csv << %w{ID TITLE STARTDATE ENDDATE DESCRIPTION URL}
          all.each do |event|
            csv << [event.title, event.start, event.end, event.description, event.external_link]
          end
        else
          csv << ["#{report} not found"]
      end
    end
  end
end
