using System;
using System.Collections;
using System.Web;
using System.Web.Hosting;

namespace TaeYoung.Common.VirtualPath
{
    /// <summary>
    /// Virtual File as Virtual Path Provider
    /// </summary>
    public class VirtualFilePathProvider : System.Web.Hosting.VirtualPathProvider
    {
        public const string VirtualPathProviderResourceLocation = "TaeYoung.Common.VirtualPath";
        public const string VirtualMasterPagePath = "~/VirtualPageDir/";
        // 마스터 페이지
        public const string MasterPageFileLocation = "~/VirtualPageDir/Site.Master";
        /// <summary>
        /// 메뉴없는 마스터 페이지
        /// </summary>
        public const string MasterPageFileLocationSub = "~/VirtualPageDir/Sub.Master";
        //public const string MasterPageFileLocationMain = "~/VirtualPageDir/Main.Master";
        public const string MasterPageFileLocationPopup = "~/VirtualPageDir/Popup.Master";
        //public const string MasterPageFileLocationNone = "~/VirtualPageDir/None.Master";
        public const string MasterPageFileLocationMobile = "~/VirtualPageDir/Mobile.Master";
        // 로그아웃
        public const string LogoutPageFileLocation = "~/VirtualPageDir/Logout.aspx";

        /// <summary>
        /// Initializes a new instance of the <see cref="MasterVirtualPathProvider"/> class.
        /// </summary>
        public VirtualFilePathProvider()
            : base()
        {
        }

        /// <summary>
        /// Gets a value that indicates whether a file exists in the virtual file system.
        /// </summary>
        /// <param name="virtualPath">The path to the virtual file.</param>
        /// <returns>
        /// true if the file exists in the virtual file system; otherwise, false.
        /// </returns>
        public override bool FileExists(string virtualPath)
        {
            if (IsPathVirtual(virtualPath))
            {
                VirtualFilePath file = (VirtualFilePath)GetFile(virtualPath);
                return (file == null) ? false : true;
            }
            else
            {
                //return false;
                return Previous.FileExists(virtualPath);
            }
        }

        /// <summary>
        /// Gets a virtual file from the virtual file system.
        /// </summary>
        /// <param name="virtualPath">The path to the virtual file.</param>
        /// <returns>
        /// A descendent of the <see cref="T:System.Web.Hosting.VirtualFile"></see> class that represents a file in the virtual file system.
        /// </returns>
        public override VirtualFile GetFile(string virtualPath)
        {
            if (IsPathVirtual(virtualPath))
            {
                return new VirtualFilePath(virtualPath);
            }
            else
            {
                return Previous.GetFile(virtualPath);
            }
        }

        /// <summary>
        /// Creates a cache dependency based on the specified virtual paths.
        /// </summary>
        /// <param name="virtualPath">The path to the primary virtual resource.</param>
        /// <param name="virtualPathDependencies">An array of paths to other resources required by the primary virtual resource.</param>
        /// <param name="utcStart">The UTC time at which the virtual resources were read.</param>
        /// <returns>
        /// A <see cref="T:System.Web.Caching.CacheDependency"></see> object for the specified virtual resources.
        /// </returns>
        public override System.Web.Caching.CacheDependency GetCacheDependency(string virtualPath, IEnumerable virtualPathDependencies, DateTime utcStart)
        {
            return null;
        }

        /// <summary>
        /// Determines whether [is path virtual] [the specified virtual path].
        /// </summary>
        /// <param name="virtualPath">The virtual path.</param>
        /// <returns>
        /// 	<c>true</c> if [is path virtual] [the specified virtual path]; otherwise, <c>false</c>.
        /// </returns>
        private static bool IsPathVirtual(string virtualPath)
        {
            String checkPath = VirtualPathUtility.ToAppRelative(virtualPath);
            return checkPath.StartsWith(VirtualMasterPagePath, StringComparison.InvariantCultureIgnoreCase);
        }
    }
}
