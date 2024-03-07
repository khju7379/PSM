using System;
using System.Data;
using System.Collections;
using TaeYoung.Common;
using JINI.Control.WebControl;


namespace TaeYoung.Portal.Admin.Cmn
{
    /// <summary>
    /// 클래스 설명을 기술한다.
    /// </summary>
    public partial class AM102020 : BasePage
    {
        public AM102020()
		{
			//this.Popup = true;
		}

		

		#region OnLangInit - 다국어 처리 데이터 정의
		/// <summary>
		/// 다국어 처리 데이터 정의
		/// </summary>
		/// <param name="e">arguments</param>
		protected override void OnLangInit(EventArgs e)
		{
			// cs 에서 다국어 호출을 지정 (다국어코드와 설명을 추가하여 cs에서 강제로 호출한다.)
			//LangCodeList.Add(new string[] { "TEST0006", "제목" });

			// 다국어 처리를 위하여 컨트롤 정의 부분은 OnLageLoad에 정의해야함. (데이터그리드, SearchView, 웹트리)
			InitGrid();
			InitTree();
		}
		#endregion

		#region Page_Load - 페이지 로드
		/// <summary>
		/// 페이지 로드
		/// </summary>
		/// <param name="sender">this</param>
		/// <param name="e">arguments</param>
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
			}
		}
		#endregion

		#region InitGrid - 그리드 초기화
		/// <summary>
		/// 그리드 초기화
		/// </summary>
		private void InitGrid()
		{
            grid1.AddField("GRPID", "Grid01", "그룹ID", "20%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Center, "Grid1RowClick", SheetHidden.False, SheetFixable.False);
            grid1.AddField("GRPNAME", "Grid02", "그룹명", "80%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Left, "Grid1RowClick", SheetHidden.False, SheetFixable.False);

            grid1.TypeName = "Common.AMBiz";
            grid1.MethodName = "GetGroupList";

            grid2.AddField("GRPID", "Grid01", "그룹ID", "20%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Center, "Grid2RowClick", SheetHidden.False, SheetFixable.False);
            grid2.AddField("GRPNAME", "Grid02", "그룹명", "80%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Left, "Grid2RowClick", SheetHidden.False, SheetFixable.False);

            grid2.TypeName = "Common.AMBiz";
			grid2.MethodName = "GetGroupAcl";

            grid3.AddField("USRID", "Grid03", "그룹멤버ID", "30%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Center, "null", SheetHidden.False, SheetFixable.False);
            grid3.AddField("USRNM", "Grid04", "그룹멤버명", "40%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Left, "null", SheetHidden.False, SheetFixable.False);
            grid3.AddField("COMPANYNAME", "Grid05", "법인명", "30%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Left, "null", SheetHidden.False, SheetFixable.False);

            grid3.TypeName = "Common.AMBiz";
            grid3.MethodName = "GetGroupMember";

            grid4.AddField("USRID", "Grid03", "그룹멤버ID", "30%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Center, "null", SheetHidden.False, SheetFixable.False);
            grid4.AddField("USRNM", "Grid04", "그룹멤버명", "40%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Left, "null", SheetHidden.False, SheetFixable.False);
            grid4.AddField("COMPANYNAME", "Grid05", "법인명", "30%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Left, "null", SheetHidden.False, SheetFixable.False);

            grid4.TypeName = "Common.AMBiz";
            grid4.MethodName = "GetGroupMember";

            grid5.AddField("GRPID", "Grid01", "그룹ID", "20%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Center, "Grid5RowClick", SheetHidden.False, SheetFixable.False);
            grid5.AddField("GRPNAME", "Grid02", "그룹명", "80%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Left, "Grid5RowClick", SheetHidden.False, SheetFixable.False);

            grid5.TypeName = "Common.AMBiz";
            grid5.MethodName = "GetGroupByUser";

            grid6.AddField("LOGINID", "Grid03", "그룹멤버ID", "30%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Center, "Grid6RowClick", SheetHidden.False, SheetFixable.False);
            grid6.AddField("DISPLAYNAME", "Grid04", "그룹멤버명", "40%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Left, "Grid6RowClick", SheetHidden.False, SheetFixable.False);
            grid6.AddField("COMPANY", "Grid05", "법인명", "30%", SheeEditable.False, SheetDataType.Text, SheetAlign.Center, SheetAlign.Left, "Grid6RowClick", SheetHidden.False, SheetFixable.False);

            grid6.TypeName = "Common.AMBiz";
            grid6.MethodName = "GetGroupMemberAll";
		}
		#endregion

		
		

		#region InitTree - 트리 초기화
		/// <summary>
		/// 트리 초기화
		/// </summary>
		private void InitTree()
		{
			tree1.Width = 500;
			tree1.OnClick = "tree1_click";
			tree1.OnLoaded = "tree1_Loaded";
			tree1.Commonable = true;
			tree1.TypeName = "Common.MenuBiz";
			tree1.MethodName = "GetMenuAcl";
			tree1.Title = "";
			tree1.HideTitle = true;
			//tree1.EnableSearchBox = true;
			tree1.CheckBox = true;

			tree2.Width = 500;
			tree2.OnClick = "tree2_click";
			tree2.OnLoaded = "tree2_Loaded";
			tree2.Commonable = true;
            tree2.TypeName = "Common.MenuBiz";
			tree2.MethodName = "GetMenuAcl";
			tree2.Title = "";
			tree2.HideTitle = true;
			//tree2.EnableSearchBox = true;
			tree2.CheckBox = false;

            tree3.Width = 500;
            tree3.OnClick = "tree2_click";
            tree3.OnLoaded = "tree2_Loaded";
            tree3.Commonable = true;
            tree3.TypeName = "Common.MenuBiz";
            tree3.MethodName = "GetMenuAcl";
            tree3.Title = "";
            tree3.HideTitle = true;
            //tree3.EnableSearchBox = true;
            tree3.CheckBox = true;
		} 
		#endregion
    }
}