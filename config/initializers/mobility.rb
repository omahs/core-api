Mobility.configure do
  plugins do
    backend :key_value

    active_record

    reader
    writer

    backend_reader

    query

    cache

    presence

    locale_accessors [:en, :'pt-BR']
  end
end
