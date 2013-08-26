class TicketQueuesController < ApplicationController
  before_action :set_ticket_queue, only: [:show, :edit, :update, :destroy]

  # GET /ticket_queues
  # GET /ticket_queues.json
  def index
    @ticket_queues = TicketQueue.all
  end

  # GET /ticket_queues/1
  # GET /ticket_queues/1.json
  def show
  end

  # GET /ticket_queues/new
  def new
    @ticket_queue = TicketQueue.new
  end

  # GET /ticket_queues/1/edit
  def edit
  end

  # POST /ticket_queues
  # POST /ticket_queues.json
  def create
    @ticket_queue = TicketQueue.new(ticket_queue_params)

    respond_to do |format|
      if @ticket_queue.save
        format.html { redirect_to @ticket_queue, notice: 'Ticket queue was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ticket_queue }
      else
        format.html { render action: 'new' }
        format.json { render json: @ticket_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_queues/1
  # PATCH/PUT /ticket_queues/1.json
  def update
    respond_to do |format|
      if @ticket_queue.update(ticket_queue_params)
        format.html { redirect_to @ticket_queue, notice: 'Ticket queue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ticket_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_queues/1
  # DELETE /ticket_queues/1.json
  def destroy
    @ticket_queue.destroy
    respond_to do |format|
      format.html { redirect_to ticket_queues_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_queue
      @ticket_queue = TicketQueue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_queue_params
      params.require(:ticket_queue).permit(:name, :description, :url, :priority, :default_due_in, :start_date, :end_date)
    end
end
