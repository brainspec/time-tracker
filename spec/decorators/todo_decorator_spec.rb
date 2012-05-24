require 'spec_helper'

describe TodoDecorator do
  describe '#total_hours' do
    let(:todo) { Fabricate(:todo) }

    it 'rounds todo total hours' do
      def todo.total_hours; 3.666; end
      todo.decorate.total_hours.should == 3.67
    end
  end
end
