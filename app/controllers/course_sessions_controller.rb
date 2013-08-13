class CourseSessionsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :requires_current_account
  before_filter :requires_site_admin, except: [:index, :show]

  # GET /course_sessions
  # GET /course_sessions.json
  def index
    @course = Course.by_account(@current_account).find(params[:course_id])
    @course_sessions = CourseSession.by_course(@course)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_sessions }
    end
  end

  # GET /course_sessions/1
  # GET /course_sessions/1.json
  def show
    @course = Course.by_account(@current_account).find(params[:course_id])
    @course_session = CourseSession.by_course(@course).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_session }
    end
  end

  # GET /course_sessions/new
  # GET /course_sessions/new.json
  def new
    @course = Course.by_account(@current_account).find(params[:course_id])
    @course_session = CourseSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_session }
    end
  end

  # GET /course_sessions/1/edit
  def edit
    @course_session = CourseSession.find(params[:id])
  end

  # POST /course_sessions
  # POST /course_sessions.json
  def create
    @course = Course.by_account(@current_account).find(params[:course_id])
    @course_session = CourseSession.new(params[:course_session])
    @course_session.course = @course

    respond_to do |format|
      if @course_session.save
        format.html { redirect_to course_course_session_path(@course, @course_session), notice: 'Course session was successfully created.' }
        format.json { render json: @course_session, status: :created, location: course_course_session_path(@course, @course_session) }
      else
        format.html { render action: "new" }
        format.json { render json: @course_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /course_sessions/1
  # PUT /course_sessions/1.json
  def update
    @course = Course.by_account(@current_account).find(params[:course_id])
    @course_session = CourseSession.by_course(@course).find(params[:id])

    respond_to do |format|
      if @course_session.update_attributes(params[:course_session])
        format.html { redirect_to course_course_session_path(@course, @course_session), notice: 'Course session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_sessions/1
  # DELETE /course_sessions/1.json
  def destroy
    @course = Course.by_account(@current_account).find(params[:course_id])
    @course_session = CourseSession.by_course(@course).find(params[:id])
    @course_session.destroy

    respond_to do |format|
      format.html { redirect_to course_url(@course) }
      format.json { head :no_content }
    end
  end
end
