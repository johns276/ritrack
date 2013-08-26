json.array!(@ticket_queues) do |ticket_queue|
  json.extract! ticket_queue, :name, :description, :url, :priority, :default_due_in, :start_date, :end_date
  json.url ticket_queue_url(ticket_queue, format: :json)
end
