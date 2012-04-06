require 'spec_helper'

describe User do
  context '#today_total_time' do
    let(:user) { Fabricate(:user) }

    it 'returns total time of work that was done today' do
      Delorean.time_travel_to("1 day ago") do
        Fabricate(:time_entry, :user => user, :hours => 10)
      end

      Fabricate(:time_entry, :user => user, :hours => 4)
      Fabricate(:time_entry, :user => user, :hours => 5)

      user.today_total_time.should be_within(0.1).of(9.0)
    end
  end
end
