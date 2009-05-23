class Realm < ActiveRecord::Base
  validates_presence_of :name, :locale

  def to_param
    self.pseudo_id
  end

  def before_save
    self.pseudo_id = "#{self.name.sanitise}-#{self.locale.downcase}"
  end
end
