require 'spec_helper'

describe TimeEntry do
  context 'overdue' do
    let(:user) { Fabricate(:user) }

    it 'validates today total time overdue' do
      time_entry = Fabricate.build(:time_entry, user: user, hours: 17)
      time_entry.save

      time_entry.errors[:hours].should include("Today total time is overdued by 1.0 hours")
    end
  end
end
