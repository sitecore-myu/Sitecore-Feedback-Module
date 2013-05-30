<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedbackErrorPage.aspx.cs" Inherits="Sitecore.Feedback.Module.PresentationLayer.FeedbackErrorPage" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Sitecore :: Error</title>
    <meta name="author">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <script type="text/javascript" src="/sitecore modules/Shell/Sitecore Feedback Module//js/jquery-1.9.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/sitecore modules/Shell/Sitecore Feedback Module/css/FeedbackErrorPage.css">
</head>
<body>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".log_link").click(function() {
                $(".log_message").toggle('slow');
                return false;
            });
        });
    </script>
    <form id="form1" runat="server">
        <div class="feedback_error">
            <a class="logo" href="/"></a>
            <div class="content">
                <asp:MultiView ID="mvSendFeedback" runat="server" ActiveViewIndex="0">
                    <asp:View ID="vSendFeedback" runat="server">
                        <div class="error_info">
                            <h1>Uncritical exception occured</h1>
                            <p>Luckily, we have the <strong><a href='#' class="log_link">logs</a></strong>! If you send them to developers, they will be happy to fix it.</p>
                            <div class="log_message">
                                <%
                                    Response.Write("<p><strong>" + Session["ErrorLog_Message"] + "</strong></p>");
                                    Response.Write("<p>" + Session["ErrorLog_StackTrace"] + "</p>");
                                %>
                            </div>
                        </div>
                        <div class="form_error">
                            <div class="form_inner">
                                <div class="validators">
                                    <asp:ValidationSummary ID="RegisterUserValidation" runat="server" ValidationGroup="vgFeedback" ShowSummary="true" />
                                </div>
                                <div class="control">
                                    <label>Email:</label>
                                    <asp:TextBox runat="server" ID="tbEmail"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="EmailRFV" Display="Dynamic" runat="server" ControlToValidate="tbEmail"
                                        ErrorMessage="Email is required." CssClass="validationError" ValidationGroup="vgFeedback">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="EmailREV" runat="server" CssClass="validationError"
                                        ErrorMessage="Please enter a valid email" Display="Dynamic" ValidationExpression="^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$"
                                        ValidationGroup="vgFeedback" ControlToValidate="tbEmail">*</asp:RegularExpressionValidator>
                                </div>
                                <div class="control">
                                    <label>Comment:</label><asp:TextBox runat="server" ID="tbComment" Rows="12" TextMode="MultiLine" Height="200px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rvfComment" Display="Dynamic" runat="server" ControlToValidate="tbComment"
                                        ErrorMessage="Comment is required." CssClass="validationError" ValidationGroup="vgFeedback">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="tbComment" ID="revComment" ValidationGroup="vgFeedback"
                                        ValidationExpression="^[\s\S]{1,1000}$" runat="server" ErrorMessage="Maximum 1000 characters allowed.">
                                    </asp:RegularExpressionValidator>
                                </div>
                                <div class="control btn">
                                    <asp:Button CssClass="button" runat="server" ID="btnSendFeedback" OnClick="btnSendFeedback_Click" Text="Send feedback" ValidationGroup="vgFeedback" />
                                </div>
                            </div>
                        </div>
                    </asp:View>
                    <asp:View ID="vEnd" runat="server">
                        <h1>Thanks for you Feedback!</h1>
                    </asp:View>
                </asp:MultiView>
            </div>
        </div>
    </form>
</body>
</html>
