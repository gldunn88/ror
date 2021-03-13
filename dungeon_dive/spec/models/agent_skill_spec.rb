require 'rails_helper'

RSpec.describe AgentSkill, type: :model do
  let (:agent) { Agent.create(name: 'Sally Dogood', description: 'An innocent old lady with a chainsaw') }
  let (:skill) { Skill.create(name: 'Leap', description: 'Leap as the majestic bullfrog of old', stat_id: Stat.where(name: 'Agility').take.id) }

  describe 'Valid when' do
    it 'has a non-nil modifier, agent, and skill assigned' do
      agentSkill = AgentSkill.new(modifier: 0, agent_id: agent.id, skill_id: skill.id)
      expect(agentSkill).to be_valid
    end
  end

  describe 'Invalid when' do 
    it 'is not initialized' do
      agentSkill = AgentSkill.new()
      expect(agentSkill).to_not be_valid
    end

    it 'has no modifier' do
      agentSkill = AgentSkill.new(modifier: nil, agent_id: agent.id, skill_id: skill.id)
      expect(agentSkill).to_not be_valid
    end

    it 'has no agent' do
      agentSkill = AgentSkill.new(modifier: 0, agent_id: nil, skill_id: skill.id)
      expect(agentSkill).to_not be_valid
    end

    it 'has no skill' do
      agentSkill = AgentSkill.new(modifier: 0, agent_id: agent.id, skill_id: nil)
      expect(agentSkill).to_not be_valid
    end

    it 'refers to a skill the agent already has' do
      AgentSkill.create(modifier: 0, agent_id: agent.id, skill_id: skill.id)
      agentSkill = AgentSkill.new(modifier: 0, agent_id: agent.id, skill_id: skill.id)
      expect(agentSkill).to_not be_valid
    end
  end
end
