class Installation < ApplicationRecord
  belongs_to :technician, optional: true

  validate :technician_presence_custom_message

  def technician_presence_custom_message
    errors.add(:base, "El técnico debe existir.") unless technician.present?
  end

  validate :no_overlapping_installations
  validate :at_least_one_hour_between_installations

  private

  # Primera validación: Sin traslapo
  def no_overlapping_installations
    return unless technician && starts_at && ends_at

    overlap = Installation
      .where(technician_id: technician.id)
      .where.not(id: id)
      .where("starts_at < ? AND ? < ends_at", ends_at, starts_at)

    if overlap.exists?
      errors.add(:base, "El/la técnico/a ya tiene una instalación en este horario.")
    end
  end

  # Segunda validación: Al menos una hora de diferencia entre instalaciones
  def at_least_one_hour_between_installations
    return unless technician && starts_at && ends_at

    buffer_overlap = Installation
      .where(technician_id: technician.id)
      .where.not(id: id)
      .where("starts_at < ? AND ? < ends_at", ends_at + 1.hour, starts_at - 1.hour)

    if buffer_overlap.exists?
      errors.add(:base, "El/la técnico/a debe contar con al menos una hora para poder transportarse.")
    end
  end
end