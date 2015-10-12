class ListPolicy
  class Scope
    attr_reader :scope, :user

    def initialize(scope, user)
      @scope, @user = scope, user
    end

    def resolve
      scope.where(user_id: user.id) | scope.where(permissions: ['open', 'viewable'])
     # scope.where('user_id = ? OR permissions = open OR permissions = viewable', user.id)
    end

  end

  attr_reader :list, :user

  def initialize(list, user)
    @list, @user = list, user
  end

  def show?
    list.permissions == 'open' || list.permissions = 'viewable' || user == list.user
  end

  def update?
    list.permissions == 'open' || user == list.user
  end
end
