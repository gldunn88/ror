require 'rails_helper'

RSpec.describe Association, type: :model do

  let(:original_assoc) { Association.create(name: 'Red Gobbo Squad', description: 'A bunch of gobbos, red in color' ) }

  describe 'Valid when' do 
    it 'is has a unique name and a description' do
      association = Association.new(name: 'example', description: 'example' )
      expect(association).to be_valid
    end

  end

  describe 'Invalid when' do
    it 'has a nil name' do
      association = Association.new(name: nil, description: 'example' )
      expect(association).to_not be_valid
    end
    
    it 'has an empty name' do
      association = Association.new(name: '', description: 'example' )
      expect(association).to_not be_valid
    end

    it 'has a nil description' do
      association = Association.new(name: 'example', description: nil )
      expect(association).to_not be_valid
    end

    it 'has an empty description' do
      association = Association.new(name: 'example', description: '' )
      expect(association).to_not be_valid
    end

    it 'has the same name as an existing Association' do
      association = Association.new(name: original_assoc.name, description: 'example' )
      expect(association).to_not be_valid
    end
  end
end
