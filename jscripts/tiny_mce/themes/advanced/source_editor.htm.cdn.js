document.open();document.write("\u003Chtml xmlns=\"http://www.w3.org/1999/xhtml\"\u003E\r\n\u003Chead\u003E\r\n\t\u003Cmeta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" /\u003E\r\n\t\u003Ctitle\u003E{#advanced_dlg.code_title}\u003C/title\u003E\r\n\t\u003Cscript type=\"text/javascript\" src=\"" + document.location.protocol +"//s3.amazonaws.com/tinymce-cdn/themes/advanced/../../tiny_mce_popup.js\"\u003E\u003C/script\u003E\r\n\t\u003Cscript type=\"text/javascript\" src=\"" + document.location.protocol +"//s3.amazonaws.com/tinymce-cdn/themes/advanced/js/source_editor.js\"\u003E\u003C/script\u003E\r\n\t\u003Cbase target=\"_self\" /\u003E\r\n\u003C/head\u003E\r\n\u003Cbody onresize=\"resizeInputs();\" style=\"display:none; overflow:hidden;\"\u003E\r\n\t\u003Cform name=\"source\" onsubmit=\"saveContent();return false;\" action=\"#\"\u003E\r\n\t\t\u003Cdiv style=\"float: left\" class=\"title\"\u003E{#advanced_dlg.code_title}\u003C/div\u003E\r\n\r\n\t\t\u003Cdiv id=\"wrapline\" style=\"float: right\"\u003E\r\n\t\t\t\u003Cinput type=\"checkbox\" name=\"wraped\" id=\"wraped\" onclick=\"toggleWordWrap(this);\" class=\"wordWrapCode\" /\u003E\u003Clabel for=\"wraped\"\u003E{#advanced_dlg.code_wordwrap}\u003C/label\u003E\r\n\t\t\u003C/div\u003E\r\n\r\n\t\t\u003Cbr style=\"clear: both\" /\u003E\r\n\r\n\t\t\u003Ctextarea name=\"htmlSource\" id=\"htmlSource\" rows=\"15\" cols=\"100\" style=\"width: 100%; height: 100%; font-family: 'Courier New',Courier,monospace; font-size: 12px;\" dir=\"ltr\" wrap=\"off\" class=\"mceFocus\"\u003E\u003C/textarea\u003E\r\n\r\n\t\t\u003Cdiv class=\"mceActionPanel\"\u003E\r\n\t\t\t\u003Cdiv style=\"float: left\"\u003E\r\n\t\t\t\t\u003Cinput type=\"submit\" name=\"insert\" value=\"{#update}\" id=\"insert\" /\u003E\r\n\t\t\t\u003C/div\u003E\r\n\r\n\t\t\t\u003Cdiv style=\"float: right\"\u003E\r\n\t\t\t\t\u003Cinput type=\"button\" name=\"cancel\" value=\"{#cancel}\" onclick=\"tinyMCEPopup.close();\" id=\"cancel\" /\u003E\r\n\t\t\t\u003C/div\u003E\r\n\t\t\u003C/div\u003E\r\n\t\u003C/form\u003E\r\n\u003C/body\u003E\r\n\u003C/html\u003E\r\n");document.close();