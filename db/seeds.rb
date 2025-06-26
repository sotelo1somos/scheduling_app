puts "Limpiando base de datos..."
Installation.destroy_all
Technician.destroy_all

puts "Creando técnicos..."
technicians = [
  Technician.create!(name: "Ana Torres"),
  Technician.create!(name: "Carlos Rodríguez"),
  Technician.create!(name: "Mariana Gómez")
]

puts "Creando instalaciones..."

start_date = Date.today
end_date = start_date + 4 # 5 días

technicians.each do |tech|
  (start_date..end_date).each do |day|
    start_hour = 8
    end_hour = 17

    current_time = Time.zone.local(day.year, day.month, day.day, start_hour)

    while (current_time + 1.hour) <= Time.zone.local(day.year, day.month, day.day, end_hour)
      duration = [1, 2].sample

      # Nos aseguramos de no pasarnos del horario permitido
      break if (current_time + duration.hours) > Time.zone.local(day.year, day.month, day.day, end_hour)

      Installation.create!(
        customer_name: Faker::Name.name,
        address: Faker::Address.full_address,
        starts_at: current_time,
        ends_at: current_time + duration.hours,
        technician: tech
      )

      # +1 hora de instalación +1 hora de traslado
      current_time += duration.hours + 1.hour
    end
  end
end

puts "Seeding terminado correctamente 🌱"