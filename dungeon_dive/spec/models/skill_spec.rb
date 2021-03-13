require 'rails_helper'

RSpec.describe Skill, type: :model do

  let(:original_skill) { Skill.create(name: 'push', description: 'example strength based skill', stat_id: Stat.where(name: 'Strength').take.id) }

  describe 'Valid when' do
    it 'has a name, description, and stat is strength' do
      skill = Skill.new(name: 'example', description: 'example', stat_id: Stat.where(name: 'Strength').take.id)
      expect(skill).to be_valid
    end

    it 'has a name, description, and stat is agility' do
      skill = Skill.new(name: 'example', description: 'example', stat_id: Stat.where(name: 'Agility').take.id)
      expect(skill).to be_valid
    end

    it 'has a name, description, and stat is toughness' do
      skill = Skill.new(name: 'example', description: 'example', stat_id: Stat.where(name: 'Toughness').take.id)
      expect(skill).to be_valid
    end

    it 'has a name, description, and stat is awareness' do
      skill = Skill.new(name: 'example', description: 'example', stat_id: Stat.where(name: 'Awareness').take.id)
      expect(skill).to be_valid      
    end

    it 'has a name, description, and stat is cleverness' do
      skill = Skill.new(name: 'example', description: 'example', stat_id: Stat.where(name: 'Cleverness').take.id)
      expect(skill).to be_valid      
    end

  end

  describe 'Invalid when' do
    it 'has not been initialized' do
      skill = Skill.new()
      expect(skill).to_not be_valid
    end

    it 'has nil name' do
      skill = Skill.new(name: nil, description: 'example', stat_id: Stat.where(name: 'Strength').take.id)
      expect(skill).to_not be_valid
    end

    it 'has empty name' do
      skill = Skill.new(name: '', description: 'example', stat_id: Stat.where(name: 'Strength').take.id)
      expect(skill).to_not be_valid
    end

    it 'has nil description' do
      skill = Skill.new(name: 'example', description: nil, stat_id: Stat.where(name: 'Strength').take.id)
      expect(skill).to_not be_valid
    end

    it 'has empty description' do
      skill = Skill.new(name: 'example', description: '', stat_id: Stat.where(name: 'Strength').take.id)
      expect(skill).to_not be_valid
    end

    it 'has nil stat' do
      skill = Skill.new(name: 'example', description: 'example', stat_id: nil)
      expect(skill).to_not be_valid
    end

    it 'has invalid stat' do
      skill = Skill.new(name: 'example', description: 'example', stat_id: -1)
      expect(skill).to_not be_valid
    end

    it 'has the same name as an existing skill' do
      skill = Skill.new(name: original_skill.name, description: 'A duplicate skill', stat_id: original_skill.stat)
      expect(skill).to_not be_valid
    end

  end

end
