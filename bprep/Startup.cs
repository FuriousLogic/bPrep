using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(BPrep.Startup))]
namespace BPrep
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
