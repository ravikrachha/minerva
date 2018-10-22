class JournelEntry < ApplicationRecord
    belongs_to :app_journel

    def updated?
        self.created_at != self.updated_at
    end
end
