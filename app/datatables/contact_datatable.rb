class ContactDatatable
  delegate :params, to: :@view

  # Initlialize datatable with view.
  def initialize(view)
    @view = view
  end

  # Return data as json.
  def as_json(*)
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Contact.count,
      iTotalDisplayRecords: contacts.total_entries,
      aaData: data
    }
  end

  private

  # Build the required data.
  def data
    contacts.map do |contact|
      [
        contact.first_name,
        contact.last_name,
        contact.email_address,
        contact.phone_number,
        contact.company_name,
        contact.id
      ]
    end
  end

  # Fetch all the contacts.
  def contacts
    @contacts ||= fetch_contacts
  end

  # Fetch all the contacts
  # Also the columns are sorted according to the sort clicks.
  # Filter is applied to email so that email with
  # particular extension can be filtered out.
  def fetch_contacts
    contacts = Contact.order("#{sort_column} #{sort_direction}")
    contacts = contacts.page(page).per_page(per_page)
    if params[:sSearch].present?
      contacts = contacts.where('email_address like :search', search: "%#{params[:sSearch]}%")
    end
    contacts
  end

  def page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w(first_name last_name email_address phone_number company_name)
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end
