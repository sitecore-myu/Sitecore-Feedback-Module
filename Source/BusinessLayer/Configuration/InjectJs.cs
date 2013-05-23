
namespace Sitecore.Feedback.Module.BusinessLayer.Configuration
{
  using Sitecore.Pipelines.RenderLayout;
  using Sitecore.Web;
  using System.IO;
  using System.Web;
  using System.Web.UI;
  using System.Web.UI.HtmlControls;

  public class InjectJs
  {
    public void Process(RenderLayoutArgs args)
    {
      if (Context.Site.Name == "shell")
        return;

      var head = WebUtil.FindControlOfType(Context.Page.Page, typeof(HtmlHead));
      if (head != null)
      {
        var filesJs = Directory.GetFiles(HttpContext.Current.Server.MapPath(Constants.FolderJs));
        foreach (var fileJs in filesJs)
        {
          var extension = Path.GetExtension(fileJs);
          if (extension != null && extension.Contains(".js"))
          {
            IncludeJsToControl(head, Constants.FolderJs+Path.GetFileName(fileJs));
          }
        }
      }
    }

    public Control IncludeJsToControl(Control control, string jsfile)
    {
      var child = new HtmlGenericControl("script");
      child.Attributes.Add("type", "text/javascript");
      child.Attributes.Add("src", jsfile);
      control.Controls.Add(child);
      return control;
    }
  }
}