class DataStruct < OpenStruct
  def as_json(*)
    super.as_json['table']
  end
end
