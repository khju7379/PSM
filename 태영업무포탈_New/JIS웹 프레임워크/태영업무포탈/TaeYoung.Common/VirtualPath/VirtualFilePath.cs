using System.IO;
using System.Reflection;
using System.Web;
using System.Web.Hosting;

namespace TaeYoung.Common.VirtualPath
{
    /// <summary>
    /// Virtual File
    /// </summary>
    public class VirtualFilePath : VirtualFile
    {
        private string virPath;

        /// <summary>
        /// Initializes a new instance of the <see cref="VirtualFilePath"/> class.
        /// </summary>
        /// <param name="virtualPath">The virtual path to the resource represented by this instance.</param>
        public VirtualFilePath(string virtualPath)
            : base(virtualPath)
        {
            this.virPath = virtualPath;
        }

        /// <summary>
        /// When overridden in a derived class, returns a read-only stream to the virtual resource.
        /// </summary>
        /// <returns>A read-only stream to the virtual file.</returns>
        public override Stream Open()
        {
            if (!(HttpContext.Current == null))
            {
                if (HttpContext.Current.Cache[virPath] == null && ReadResource(virPath) != null)
                {
                    HttpContext.Current.Cache.Insert(virPath, ReadResource(virPath));
                }

                //StreamReader sr = new StreamReader(ReadResource(virPath));

                return ReadResource(virPath);

                //StreamReader sr = new StreamReader((Stream)HttpContext.Current.Cache[virPath]);
                //string text = sr.ReadToEnd();

                //return (Stream)HttpContext.Current.Cache[virPath];
            }
            else
            {
                return ReadResource(virPath);
            }
        }

        /// <summary>
        /// read resource file
        /// </summary>
        /// <param name="embeddedFileName"></param>
        /// <returns></returns>
        private static Stream ReadResource(string embeddedFileName)
        {
            string resourceFileName = VirtualPathUtility.GetFileName(embeddedFileName);
            Assembly assembly = Assembly.GetExecutingAssembly();
            return assembly.GetManifestResourceStream(VirtualFilePathProvider.VirtualPathProviderResourceLocation + "." + resourceFileName);
        }
    }
}
