module Visible
    extend ActiveSupport::Concern 
    
    VALID_STATUSES = ['public', 'private', 'archived']

    # When included, apply validation on status
    # Allows avoidance of duplicate logic in models
    included do
        validates :status, inclusion: { in: VALID_STATUSES }
    end

    # allows a call, ala @articles.public_count or @articles.comments.public_count
    class_methods do
        def public_count
            where(status: 'public').count
        end
    end

    def archived?
        status == 'archived'
    end
end