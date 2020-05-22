# json.array! @repositories, :partial: 'repositories/repository', as: :repository
json.extract! @repositories, :id, :title, :is_public, :created_at, :updated_at