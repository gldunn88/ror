class SkillsController < ApplicationController
  def index
    @skills = Skill.all
  end

  def show
    @skill = Skill.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    render :notfound
  end

  def new 
    @stats = Stat.all
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)

    if @skill.save
      redirect_to @skill
    else
      render :new
    end
  end

  def edit
    @skill = Skill.find(params[:id])
  end

  def update
    @skill = Skill.find(params[:id])

    if @skill.update(skill_params)
      redirect_to @skill
    else
      render :edit
    end
  rescue ActiveRecord::RecordNotFound
    render :notfound  
  end

  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy

    redirect_to "/skills"

  rescue ActiveRecord::RecordNotFound
    render :notfound  
  end

  private
    def skill_params
      params.require(:skill).permit(:name, :description, :stat_id)
    end
end
