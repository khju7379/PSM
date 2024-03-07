using System;
using System.Web;
using System.Web.Hosting;
using TaeYoung.Common.VirtualPath;

namespace TaeYoung.Common
{
    public class WebModule : IHttpModule
    {
        public void Dispose()
        {

        }

        public void Init(HttpApplication context)
        {

            context.BeginRequest += new EventHandler(context_BeginRequest);
        }

		void context_BeginRequest(object sender, EventArgs e)
		{
            VirtualFilePathProvider vpp = new VirtualFilePathProvider();
            HostingEnvironment.RegisterVirtualPathProvider(vpp);
            SetEnabledCrossDmainAjaxCall();
		}

        private void SetEnabledCrossDmainAjaxCall()
        {
            HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", "*");
            if(HttpContext.Current.Request.HttpMethod == "OPTIONS")
            {
                HttpContext.Current.Response.AddHeader("X-Frame-Options", "SAMEORIGIN");
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Methods", "GET, POST");
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Headers", "Content-Type, Accept");
                HttpContext.Current.Response.AddHeader("Access-Control-Max-Age", "1728000");
                HttpContext.Current.Response.End();
            }
        }

    }
}
