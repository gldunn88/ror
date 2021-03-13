require 'rails_helper'

RSpec.describe AgentStat, type: :model do
  
  let (:agent) { Agent.create(name: 'Sally Dogood', description: 'An innocent old lady with a chainsaw') }
  let (:stat) { Stat.where(name: 'Agility').take! }

  describe 'Valid when' do
    it 'has a non-nil stat_value, agent, and stat assigned' do
      agentStat = AgentStat.new(stat_value: 1, agent_id: agent.id, stat_id: stat.id)
      expect(agentStat).to be_valid
    end
  end

  describe 'Invalid when' do
    it 'is not initialized' do
      agentStat = AgentStat.new()
      expect(agentStat).to_not be_valid
    end

    it 'has no stat_value' do
      agentStat = AgentStat.new(stat_value: nil, agent_id: agent.id, stat_id: stat.id)
      expect(agentStat).to_not be_valid
    end

    it 'has no agent' do
      agentStat = AgentStat.new(stat_value: 1, agent_id: nil, stat_id: stat.id)
      expect(agentStat).to_not be_valid
    end

    it 'has no stat' do
      agentStat = AgentStat.new(stat_value: 1, agent_id: agent.id, stat_id: nil)
      expect(agentStat).to_not be_valid
    end

    it 'has a stat value below 0' do
      agentStat = AgentStat.new(stat_value: -1, agent_id: agent.id, stat_id: stat.id)
      expect(agentStat).to_not be_valid
    end

    it 'refers to a stat the agent already has' do
      AgentStat.create(stat_value: 1, agent_id: agent.id, stat_id: stat.id)
      agentStat = AgentStat.new(stat_value: 1, agent_id: agent.id, stat_id: stat.id)
      expect(agentStat).to_not be_valid
    end

  end
end
