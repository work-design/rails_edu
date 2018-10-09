module SurveyMonkey
  extend self

  def oauth_client(scope = [])
    return @oauth_client if @oauth_client
    oauth = OmniAuth::Strategies::Surveymonkey.new(
      nil, # App - nil seems to be ok?!
      SETTING['sm_client_id'],
      SETTING['sm_client_secret'],
      scope: []
    )
    @oauth_client = oauth.client
    @oauth_client.site = 'https://api.surveymonkey.com/v3'
    @oauth_client.options[:raise_errors] = false
    @oauth_client
  end

  def client
    @client ||= OAuth2::AccessToken.new oauth_client, SmSetting.working&.access_token
  end

  def folder_id
    return @folder_id if @folder_id
    result = get 'survey_folders'
    if result.present?
      folder = result['data'].find { |i| i['title'] == SETTING['sm_survey_folder'] }
      @folder_id = folder['id']
    end
  end

  def post(path, opts = {}, &block)
    opts[:headers] ||= {}
    opts[:headers]['Content-Type'] = 'application/json'
    opts[:body] = opts[:body].to_json
    r = client.post(path, opts, &block)
    if r.status >= 200 && r.status < 300
      r.parsed
    elsif r.status == 429
      switchover
      post(path, opts, &block)
    else
      {}
    end
  end

  def get(path, opts = {}, &block)
    r = client.get(path, opts, &block)
    if r.status >= 200 && r.status < 300
      r.parsed
    elsif r.status == 429
      switchover
      get(path, opts, &block)
    else
      {}
    end
  end

  def create_survey(title = 'Please changed', **options)
    SurveyMonkey.post 'surveys', body: { title: title, folder_id: folder_id, **options }
  end

  def switchover
    token = SurveyMonkey.client.instance_variable_get(:@token)
    SmSetting.where(access_token: token).update_all(working: false, limit_at: Time.now) unless SmSetting.where(working: true).count <= 1
    @client = nil
  end

end
