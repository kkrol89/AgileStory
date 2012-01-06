class MembershipFormAutocompletion
  constructor: (@selector)->
    $(@selector + ' #membership_user_email').autocomplete({ source: @emails_collection(), minLength: 0 }).focus(->
      if (this.value == "")
        $(this).autocomplete('search', "")
    )
  emails_collection: ->
    if $(@selector + ' .user_emails').attr('data-user-emails')
      JSON.parse($(@selector + ' .user_emails').attr('data-user-emails'))

$(=> new MembershipFormAutocompletion('#new_membership'))