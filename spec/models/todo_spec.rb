require 'spec_helper'

describe Todo do
  describe '.find_or_create_by_bcx_hash' do
    let :bcx_hash do
      data = JSON.parse File.read("#{Rails.root}/spec/assets/todo.json")
      Hashie::Mash.new(data)
    end

    it 'creates todo' do
      todo = Todo.find_or_create_by_bcx_hash(bcx_hash)
      todo.bcx_id.should == 1
    end

    it 'updates todo' do
      todo = double
      todo.should_receive(:save!)
      Todo.should_receive(:find) { todo }
      Todo.find_or_create_by_bcx_hash(bcx_hash).should == todo
    end
  end
end
