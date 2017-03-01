{*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.7                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2017                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*}
{* this template is used for adding/editing/deleting financial type  *}
<div class="crm-block crm-form-block crm-financial_type-form-block">
  {if $action eq 8}
    <div class="messages status">
      <div class="icon inform-icon"></div>
      {ts}WARNING: You cannot delete a financial type if it is currently used by any Contributions, Contribution Pages or Membership Types. Consider disabling this option instead.{/ts} {ts}Deleting a financial type cannot be undone. Unbalanced transactions may be created if you delete this account.{/ts} {ts}Do you want to continue?{/ts}
      </div>
  {else}
    <div class="crm-submit-buttons">{include file="CRM/common/formButtons.tpl" location="top"}</div>

    <table class="form-layout">

      <tr class="crm-contribution-form-block-account_relationship">
      <td class="label">{$form.account_relationship.label}</td>
  <td class="html-adjust">{$form.account_relationship.html}</td>
      </tr>
      <tr class="crm-contribution-form-block-financial_account_id">
      <td class="label">{$form.financial_account_id.label}</td>
  <td class="html-adjust">{$form.financial_account_id.html}</td>
      </tr>

    </table>
   {/if}
   <div class="crm-submit-buttons">{include file="CRM/common/formButtons.tpl" location="botttom"}</div>
</div>

<script language="JavaScript" type="text/javascript">
{literal}
CRM.$(function($) {
  $("#financial_account_id").change(function() {
    {/literal}
      relationID = "#account_relationship"
      financialAccountID = "#financial_account_id"
      callbackURL = "{crmURL p='civicrm/ajax/rest' h=0 q='className=CRM_Financial_Page_AJAX&fnName=jqFinancialRelation'}"
    {literal}
    var financialId = $("#financial_account_id").val();
    var check = $(relationID).val();
    if (check == 'select' || financialId == 'select') {
      callbackURL = callbackURL+"&_value=" + financialId;
      $.ajax({
        url: callbackURL,
      	context: document.body,
      	success: function(data, textStatus) {
          $(relationID).html("");//clear old options
  	  data = eval(data);//get json array
          if (data != null) {
    	    for (i = 0; i < data.length; i++) {
      	      if (data[i].selected == 'Selected') {
                var idf = data[i].value;
              }
              $(relationID).get(0).add(new Option(data[i].name, data[i].value), document.all ? i : null);
    	    }
          }
  	  if (idf != null) {
      	    $(relationID).val(idf);
          }
        }
      });
    }
    if (financialId == 'select') {
      {/literal}
        callbackURLs = "{crmURL p='civicrm/ajax/rest' h=0 q='className=CRM_Financial_Page_AJAX&fnName=jqFinancial'}"
      {literal}
      callbackURLs = callbackURLs + "&_value=select";
      $.ajax({
        url: callbackURLs,
        context: document.body,
        success: function(data, textStatus) {
          $(financialAccountID).html("");//clear old options
    	  data = eval(data);//get json array
          if (data != null) {
      	    for (i = 0; i < data.length; i++) {
              $(financialAccountID).get(0).add(new Option(data[i].name, data[i].value), document.all ? i : null);
            }
          }
        }
      });
    }
  });
  $("#account_relationship").change(function() {
    {/literal}
      relationID = "#account_relationship"
      financialAccountID = "#financial_account_id"
      callbackURLs = "{crmURL p='civicrm/ajax/rest' h=0 q='className=CRM_Financial_Page_AJAX&fnName=jqFinancial'}"
    {literal}
    var financialId = $("#account_relationship").val();
    var check = $(financialAccountID).val();
    callbackURLs = callbackURLs+"&_value="+financialId;
    $.ajax({
      url: callbackURLs,
      context: document.body,
      success: function(data, textStatus) {
        $(financialAccountID).html("");//clear old options
        data = eval(data);//get json array
        if (data != null) {
          for (i = 0; i < data.length; i++) {
       	    if (data[i].selected == 'Selected') {
              var idf = data[i].value;
            }
	    $(financialAccountID).get(0).add(new Option(data[i].name, data[i].value), document.all ? i : null);
          }
        }
  	if (idf != null) {
    	  $(financialAccountID).val(idf);
        }
      }
    });
    if (financialId == 'select') {
      {/literal}
        callbackURL = "{crmURL p='civicrm/ajax/rest' h=0 q='className=CRM_Financial_Page_AJAX&fnName=jqFinancialRelation'}"
      {literal}
      callbackURL = callbackURL+"&_value=select";
      $.ajax({
        url: callbackURL,
        context: document.body,
        success: function(data, textStatus) {
          $(relationID).html("");//clear old options
          data = eval(data);//get json array
          if (data != null) {
            for (i = 0; i < data.length; i++) {
              if (data[i].selected == 'Selected') {
                var idf = data[i].value;
              }
              $(relationID).get(0).add(new Option(data[i].name, data[i].value), document.all ? i : null);
            }
          }
          if (idf != null) {
            $(relationID).val(idf);
          }
        }
      });
    }
  });
});
{/literal}
</script>
