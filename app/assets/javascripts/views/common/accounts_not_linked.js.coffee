FitgemClient.Views.Common ||= {}

class FitgemClient.Views.Common.AccountsNotLinkedView extends Backbone.View
  template: JST['templates/common/accounts_not_linked']

  render: ->
    $(@el).html(@template())
    return this