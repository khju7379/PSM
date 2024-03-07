Ext.namespace("GW.OrgMap");
GW.OrgMap.Resource = {
    // 메시지박스 제목
    Info_ko: "알림",
    Info_en: "Information",
    Info_es: "Information",
    Info_cn: "通知",

    Warning_ko: "경고",
    Warning_en: "Warning",
    Warning_es: "Warning",
    Warning_cn: "警告",

    Error_ko: "에러",
    Error_en: "Error",
    Error_es: "Error",
    Error_cn: "错误",

    // Ajax에러메시지
    AjaxFailMsg_ko: "서버로의 Ajax Request에 대해 실패했습니다.<br/>조직도 창을 닫습니다.",
    AjaxFailMsg_en: "The Ajax Request to server is failed.<br/>Closing Orgchart.",
    AjaxFailMsg_es: "The Ajax Request to server is failed.<br/>Closing Orgchart.",
    AjaxFailMsg_cn: "对服务器的Ajax Request产生失败。<br/>组织图的窗体也要关闭。",

    AjaxErrorMsg1_ko: "서버에서 에러가 발생했습니다.<br/>에러내용은 다음과 같습니다.<br/><br/>",
    AjaxErrorMsg1_en: "There are errors in server.<br/>The error information is the same to next error.<br/><br/>",
    AjaxErrorMsg1_es: "There are errors in server.<br/>The error information is the same to next error.<br/><br/>",
    AjaxErrorMsg1_cn: "服务器上发生错误信息。<br/>以下是错误内容。<br/><br/>",

    AjaxErrorMsg2_ko: "<br/><br/>조직도 창을 닫습니다.",
    AjaxErrorMsg2_en: "<br/><br/>Closing Orgchart.",
    AjaxErrorMsg2_es: "<br/><br/>Closing Orgchart.",
    AjaxErrorMsg2_cn: "<br/><br/>关闭组织图的窗体。",

    // 회사 목록 retrieve 실패 메세지
    CompanyGetErrorMsg_ko: "회사메뉴 초기화 안됐음",
    CompanyGetErrorMsg_en: "Company menu didn't initialized.",
    CompanyGetErrorMsg_es: "Company menu didn't initialized.",
    CompanyGetErrorMsg_cn: "Company menu didn't initialized.",

    // 조직도 제목
    OrgMapTitle_ko: "조직도",
    OrgMapTitle_en: "Organization Chart",
    OrgMapTitle_es: "Organization Chart",
    OrgMapTitle_cn: "组织图",

    // 메일작성 조직도 제목
    MailOrgChartTitle_ko: "메일수신처 지정",
    MailOrgChartTitle_en: "Specifying addressee",
    MailOrgChartTitle_es: "Specifying addressee",
    MailOrgChartTitle_cn: "收件人指定",

    // 모임요청 조직도 제목
    AppointmentOrgChartTitle_ko: "참석자와 리소스 선택",
    AppointmentOrgChartTitle_en: "Select participator and resource",
    AppointmentOrgChartTitle_es: "Select participator and resource",
    AppointmentOrgChartTitle_cn: "选择参与者和资源",

    AppointmentToBoxName_ko: "필수",
    AppointmentToBoxName_en: "Compulsory",
    AppointmentToBoxName_es: "Compulsory",
    AppointmentToBoxName_cn: "必需",

    AppointmentCcBoxName_ko: "선택",
    AppointmentCcBoxName_en: "Select",
    AppointmentCcBoxName_es: "Select",
    AppointmentCcBoxName_cn: "选择",

    AppointmentBccBoxName_ko: "리소스",
    AppointmentBccBoxName_en: "Resource",
    AppointmentBccBoxName_es: "Resource",
    AppointmentBccBoxName_cn: "Resource",

    // 연락처 조직도 제목
    ContactOrgChartTitle_ko: "연락처 추가 대상 선택",
    ContactOrgChartTitle_en: "Select linkman",
    ContactOrgChartTitle_es: "Select linkman",
    ContactOrgChartTitle_cn: "选择联络者",

    // 작업요청 조직도 제목
    TaskOrgChartTitle_ko: "작업 받는 사람 선택",
    TaskOrgChartTitle_en: "Select task embracer",
    TaskOrgChartTitle_es: "Select task embracer",
    TaskOrgChartTitle_cn: "选择接受者",

    // 그룹선택박스
    GroupCombo_ko: "그룹 선택",
    GroupCombo_en: "Select group",
    GroupCombo_es: "Select group",
    GroupCombo_cn: "选择群组",

    // 사용자 메일그룹
    UserCustomGroup_ko: "사용자 메일그룹",
    UserCustomGroup_en: "User mail group",
    UserCustomGroup_es: "User mail group",
    UserCustomGroup_cn: "用户邮件群组",

    // 그리드 헤더 제목
    UserRank_ko: "직위",
    UserRank_en: "Grade",
    UserRank_es: "Grade",
    UserRank_cn: "职责",

    MailGroup_ko: "메일그룹이름",
    MailGroup_en: "Name of mail group",
    MailGroup_es: "Name of mail group",
    MailGroup_cn: "Name of mail group",

    UserName_ko: "이름",
    UserName_en: "Name",
    UserName_es: "Name",
    UserName_cn: "使用者",

    UserDept_ko: "부서",
    UserDept_en: "Dept",
    UserDept_es: "Dept",
    UserDept_cn: "部门",

    UserCellPhone_ko: "휴대폰",
    UserCellPhone_en: "CellPhone",
    UserCellPhone_es: "CellPhone",
    UserCellPhone_cn: "手机",

    UserOfficeTel_ko: "사내전화",
    UserOfficeTel_en: "OfficeTelNo",
    UserOfficeTel_es: "OfficeTelNo",
    UserOfficeTel_cn: "分机号码",

    UserEmpID_ko: "사번",
    UserEmpID_en: "EmpNo",
    UserEmpID_es: "EmpNo",
    UserEmpID_cn: "工号",

    UserEmail_ko: "메일주소",
    UserEmail_en: "Email",
    UserEmail_es: "Email",
    UserEmail_cn: "邮箱",

    UserFax_ko: "Fax",
    UserFax_en: "Fax",
    UserFax_es: "Fax",
    UserFax_cn: "传真",

    UserDuty_ko: "직책",
    UserDuty_en: "Duty",
    UserDuty_es: "Duty",
    UserDuty_cn: "职责",

    UserJob_ko: "주요업무",
    UserJob_en: "Responsibilities",
    UserJob_es: "Responsibilities",
    UserJob_cn: "职责",

    UserCompany_ko: "회사",
    UserCompany_en: "CompanyName",
    UserCompany_es: "CompanyName",
    UserCompany_cn: "公司",

    UserEmpty_ko: "",
    UserEmpty_en: "",
    UserEmpty_es: "",
    UserEmpty_cn: "",

    Total_ko: "총&nbsp;",
    Total_en: "Total&nbsp;",
    Total_es: "Total&nbsp;",
    Total_cn: "共&nbsp;",

    PersonCount_ko: "&nbsp;명",
    PersonCount_en: "&nbsp;Persons",
    PersonCount_es: "&nbsp;Persons",
    PersonCount_cn: "&nbsp;位",

    // 사용자 메일 그룹 관리 제목
    CMGTitle_ko: "개인 주소록 관리",
    CMGTitle_en: "Address Book Management",
    CMGTitle_es: "Address Book Management",
    CMGTitle_cn: "Address Book Management",

    CMG_ko: "개인 주소록 그룹",
    CMG_en: "Address Book Group",
    CMG_es: "Address Book Group",
    CMG_cn: "Address Book Group",

    // 사용자 메일 그룹 그리드 헤더 제목
    CMGName_ko: "그룹이름",
    CMGName_en: "Name",
    CMGName_es: "Name",
    CMGName_cn: "Name",

    CMGDisplay_ko: "표시",
    CMGDisplay_en: "Display",
    CMGDisplay_es: "Display",
    CMGDisplay_cn: "Display",

    CMGOrder_ko: "순서",
    CMGOrder_en: "Order",
    CMGOrder_es: "Order",
    CMGOrder_cn: "Order",

    CMGDesc_ko: "설명",
    CMGDesc_en: "Description",
    CMGDesc_es: "Description",
    CMGDesc_cn: "Description",

    CMGCreator_ko: "작성자",
    CMGCreator_en: "Creator",
    CMGCreator_es: "Creator",
    CMGCreator_cn: "Creator",

    CMGCreateDate_ko: "작성일",
    CMGCreateDate_en: "Create Date",
    CMGCreateDate_es: "Create Date",
    CMGCreateDate_cn: "Create Date",

    // 사용자 메일 그룹 선택 항목 박스
    CMGAddGroup_ko: "그룹추가",
    CMGAddGroup_en: "Add Group",
    CMGAddGroup_es: "Add Group",
    CMGAddGroup_cn: "Add Group",

    CMGAddGroupTip_ko: "사용자 메일 그룹을 추가합니다.",
    CMGAddGroupTip_en: "Create new Custom Mail Group.",
    CMGAddGroupTip_es: "Create new Custom Mail Group.",
    CMGAddGroupTip_cn: "Create new Custom Mail Group.",

    CMGModGroup_ko: "그룹수정",
    CMGModGroup_en: "Modify Group",
    CMGModGroup_es: "Modify Group",
    CMGModGroup_cn: "Modify Group",

    CMGModGroupTip_ko: "선택한 그룹을 수정합니다.",
    CMGModGroupTip_en: "Modify checked Custom Mail Group.",
    CMGModGroupTip_es: "Modify checked Custom Mail Group.",
    CMGModGroupTip_cn: "Modify checked Custom Mail Group.",

    CMGDelGroup_ko: "그룹삭제",
    CMGDelGroup_en: "Delete Group",
    CMGDelGroup_es: "Delete Group",
    CMGDelGroup_cn: "Delete Group",

    CMGDelGroupTip_ko: "선택한 그룹을 삭제합니다.",
    CMGDelGroupTip_en: "Delete checked Custom Mail Group.",
    CMGDelGroupTip_es: "Delete checked Custom Mail Group.",
    CMGDelGroupTip_cn: "Delete checked Custom Mail Group.",

    CMGRefresh_ko: "새로고침",
    CMGRefresh_en: "Refresh",
    CMGRefresh_es: "Refresh",
    CMGRefresh_cn: "Refresh",

    CMGRefreshTip_ko: "해당 그룹의 멤버 리스트를 다시 로딩합니다.",
    CMGRefreshTip_en: "Refresh group member list.",
    CMGRefreshTip_es: "Refresh group member list.",
    CMGRefreshTip_cn: "Refresh group member list.",

    CMGAddMember_ko: "멤버추가",
    CMGAddMember_en: "Add Member",
    CMGAddMember_es: "Add Member",
    CMGAddMember_cn: "Add Member",

    CMGAddMemberTip_ko: "현재 그룹에 멤버를 추가합니다.",
    CMGAddMemberTip_en: "Add new member to this group",
    CMGAddMemberTip_es: "Add new member to this group",
    CMGAddMemberTip_cn: "Add new member to this group",

    CMGDelMember_ko: "멤버삭제",
    CMGDelMember_en: "Remove Member",
    CMGDelMember_es: "Remove Member",
    CMGDelMember_cn: "Remove Member",

    CMGDelMemberTip_ko: "선택된 멤버를 해당 그룹에서 제거합니다.",
    CMGDelMemberTip_en: "Remove checked member from this group.",
    CMGDelMemberTip_es: "Remove checked member from this group.",
    CMGDelMemberTip_cn: "Remove checked member from this group.",

    // 사용자 메일 그룹 메세지
    CMGMSG_InvalidGroupName_ko: "그룹 이름을 정확하게 입력해주세요.",
    CMGMSG_InvalidGroupName_en: "Invalid Group Name.",
    CMGMSG_InvalidGroupName_es: "Invalid Group Name.",
    CMGMSG_InvalidGroupName_cn: "Invalid Group Name.",

    CMGMSG_CreateGroup_ko: "그룹 생성",
    CMGMSG_CreateGroup_en: "Create Custom Group",
    CMGMSG_CreateGroup_es: "Create Custom Group",
    CMGMSG_CreateGroup_cn: "Create Custom Group",

    CMGMSG_CreateGroupTitle_ko: "새 그룹 생성",
    CMGMSG_CreateGroupTitle_en: "Create Custom Group",
    CMGMSG_CreateGroupTitle_es: "Create Custom Group",
    CMGMSG_CreateGroupTitle_cn: "Create Custom Group",

    CMGMSG_CreateGroupInprogress_ko: "그룹 생성중...",
    CMGMSG_CreateGroupInprogress_en: "In Progress...",
    CMGMSG_CreateGroupInprogress_es: "In Progress...",
    CMGMSG_CreateGroupInprogress_cn: "In Progress...",

    CMGMSG_CreateGroupFail_ko: "그룹 생성에 실패하였습니다.<br/><br/>",
    CMGMSG_CreateGroupFail_en: "Fail to create Custom Group.<br/><br/>",
    CMGMSG_CreateGroupFail_es: "Fail to create Custom Group.<br/><br/>",
    CMGMSG_CreateGroupFail_cn: "Fail to create Custom Group.<br/><br/>",

    CMGMSG_CreateGroupSucceed_ko: "그룹이 생성되었습니다.",
    CMGMSG_CreateGroupSucceed_en: "Creation Complete.",
    CMGMSG_CreateGroupSucceed_es: "Creation Complete.",
    CMGMSG_CreateGroupSucceed_cn: "Creation Complete.",

    CMGMSG_GroupNameRule_ko: "이름(영문명) 형식으로 입력해주세요.",
    CMGMSG_GroupNameRule_en: "Follow naming rule - Korean Name(English Name).",
    CMGMSG_GroupNameRule_es: "Follow naming rule - Korean Name(English Name).",
    CMGMSG_GroupNameRule_cn: "Follow naming rule - Korean Name(English Name).",

    CMGMSG_GroupNameRuleSymbol_ko: "[]()<>/ 를 제외한 특수문자는<br/>사용할 수 없습니다.",
    CMGMSG_GroupNameRuleSymbol_en: "Symbols are prohibited except []()<>/ characters.",
    CMGMSG_GroupNameRuleSymbol_es: "Symbols are prohibited except []()<>/ characters.",
    CMGMSG_GroupNameRuleSymbol_cn: "Symbols are prohibited except []()<>/ characters.",

    CMGMSG_GroupNameRuleLength_ko: "그룹이름은 200자로 제한합니다.",
    CMGMSG_GroupNameRuleLength_en: "Group name length can't exceed 200 letters.",
    CMGMSG_GroupNameRuleLength_es: "Group name length can't exceed 200 letters.",
    CMGMSG_GroupNameRuleLength_cn: "Group name length can't exceed 200 letters.",

    CMGMSG_ModGroupProhibit_ko: "자신이 생성한 그룹만 수정이 가능합니다.",
    CMGMSG_ModGroupProhibit_en: "Operation prohibited.",
    CMGMSG_ModGroupProhibit_es: "Operation prohibited.",
    CMGMSG_ModGroupProhibit_cn: "Operation prohibited.",

    CMGMSG_GroupNameIncorrect_ko: "그룹이름을 정확하게 입력해주세요.",
    CMGMSG_GroupNameIncorrect_en: "Invalid Group name.",
    CMGMSG_GroupNameIncorrect_es: "Invalid Group name.",
    CMGMSG_GroupNameIncorrect_cn: "Invalid Group name.",

    CMGMSG_ModGroup_ko: "그룹 수정중...",
    CMGMSG_ModGroup_en: "In progress…",
    CMGMSG_ModGroup_es: "In progress…",
    CMGMSG_ModGroup_cn: "In progress…",

    CMGMSG_ModGroupFail_ko: "그룹 수정에 실패하였습니다.<br/><br/>",
    CMGMSG_ModGroupFail_en: "Fail to modify Custom Group.<br/><br/>",
    CMGMSG_ModGroupFail_es: "Fail to modify Custom Group.<br/><br/>",
    CMGMSG_ModGroupFail_cn: "Fail to modify Custom Group.<br/><br/>",

    CMGMSG_ModGroupSucceed_ko: "그룹이 수정되었습니다.",
    CMGMSG_ModGroupSucceed_en: "Modification Complete.",
    CMGMSG_ModGroupSucceed_es: "Modification Complete.",
    CMGMSG_ModGroupSucceed_cn: "Modification Complete.",

    CMGMSG_DisplayDesc_ko: "보이도록 설정합니다.",
    CMGMSG_DisplayDesc_en: "Set custom group be displayed.",
    CMGMSG_DisplayDesc_es: "Set custom group be displayed.",
    CMGMSG_DisplayDesc_cn: "Set custom group be displayed.",

    CMGMSG_DelGroupProhibit_ko: "자신이 생성한 그룹만 삭제가 가능합니다.",
    CMGMSG_DelGroupProhibit_en: "Operation Prohibited.",
    CMGMSG_DelGroupProhibit_es: "Operation Prohibited.",
    CMGMSG_DelGroupProhibit_cn: "Operation Prohibited.",

    CMGMSG_DelGroup_ko: "그룹 삭제중...",
    CMGMSG_DelGroup_en: "In Progress...",
    CMGMSG_DelGroup_es: "In Progress...",
    CMGMSG_DelGroup_cn: "In Progress...",

    CMGMSG_DelGroupConfirm_ko: "</span>＂ 그룹을 정말로 <span style=\"color:red;\">삭제</span>하시겠습니까?",
    CMGMSG_DelGroupConfirm_en: "</span>＂Group will be <span style=\"color:red;\">deleted</span>. Are you sure?",
    CMGMSG_DelGroupConfirm_es: "</span>＂Group will be <span style=\"color:red;\">deleted</span>. Are you sure?",
    CMGMSG_DelGroupConfirm_cn: "</span>＂Group will be <span style=\"color:red;\">deleted</span>. Are you sure?",

    CMGMSG_DelGroupFail_ko: "그룹 삭제에 실패하였습니다.<br/><br/>",
    CMGMSG_DelGroupFail_en: "Fail to delete Custom Group.<br/><br/>",
    CMGMSG_DelGroupFail_es: "Fail to delete Custom Group.<br/><br/>",
    CMGMSG_DelGroupFail_cn: "Fail to delete Custom Group.<br/><br/>",

    CMGMSG_DelGroupSucceed_ko: "그룹이 삭제되었습니다.",
    CMGMSG_DelGroupSucceed_en: "Deletion Complete.",
    CMGMSG_DelGroupSucceed_es: "Deletion Complete.",
    CMGMSG_DelGroupSucceed_cn: "Deletion Complete.",

    CMGMSG_ModGroupMemberProhibit_ko: "자신이 생성한 그룹만 멤버 수정이 가능합니다.",
    CMGMSG_ModGroupMemberProhibit_en: "Operation Prohibited.",
    CMGMSG_ModGroupMemberProhibit_es: "Operation Prohibited.",
    CMGMSG_ModGroupMemberProhibit_cn: "Operation Prohibited.",

    CMGMSG_AddGroupMember_ko: "그룹에 추가할 멤버",
    CMGMSG_AddGroupMember_en: "Member Selection.",
    CMGMSG_AddGroupMember_es: "Member Selection.",
    CMGMSG_AddGroupMember_cn: "Member Selection.",

    CMGMSG_AddGroupMemberTitle_ko: "그룹에 멤버추가",
    CMGMSG_AddGroupMemberTitle_en: "Add group member",
    CMGMSG_AddGroupMemberTitle_es: "Add group member",
    CMGMSG_AddGroupMemberTitle_cn: "Add group member",

    CMGMSG_AddGroupMemberHIOKFail_ko: "다음 사용자는 로그인 ID 정보가 없으므로 추가할 수 없습니다.<br/>",
    CMGMSG_AddGroupMemberHIOKFail_en: "Below user(s) cannot be added since they don't have hiOK ID.<br/>",
    CMGMSG_AddGroupMemberHIOKFail_es: "Below user(s) cannot be added since they don't have hiOK ID.<br/>",
    CMGMSG_AddGroupMemberHIOKFail_cn: "Below user(s) cannot be added since they don't have hiOK ID.<br/>",

    CMGMSG_DelGroupMemberConfirm_ko: "</span>명의 멤버를 <span style=\"color:red;\">삭제</span>하시겠습니까?",
    CMGMSG_DelGroupMemberConfirm_en: "</span> of group member(s) will be <span style=\"color:red;\">deleted</span>. Are you sure?",
    CMGMSG_DelGroupMemberConfirm_es: "</span> of group member(s) will be <span style=\"color:red;\">deleted</span>. Are you sure?",
    CMGMSG_DelGroupMemberConfirm_cn: "</span> of group member(s) will be <span style=\"color:red;\">deleted</span>. Are you sure?",

    CMGMSG_DelGroupMemberProgress_ko: "멤버 삭제중...",
    CMGMSG_DelGroupMemberProgress_en: "In Progress...",
    CMGMSG_DelGroupMemberProgress_es: "In Progress...",
    CMGMSG_DelGroupMemberProgress_cn: "In Progress...",

    CMGMSG_DelGroupMemberFail_ko: "멤버 삭제에 실패하였습니다.<br/><br/>",
    CMGMSG_DelGroupMemberFail_en: "Fail to remove group member.<br/><br/>",
    CMGMSG_DelGroupMemberFail_es: "Fail to remove group member.<br/><br/>",
    CMGMSG_DelGroupMemberFail_cn: "Fail to remove group member.<br/><br/>",

    CMGMSG_DelGroupMemberSucceed_ko: "멤버가 삭제되었습니다",
    CMGMSG_DelGroupMemberSucceed_en: "Remove complete",
    CMGMSG_DelGroupMemberSucceed_es: "Remove complete",
    CMGMSG_DelGroupMemberSucceed_cn: "Remove complete",

    CMGMSG_AddGroupMemberProgress_ko: "멤버 추가중...",
    CMGMSG_AddGroupMemberProgress_en: "In Progress...",
    CMGMSG_AddGroupMemberProgress_es: "In Progress...",
    CMGMSG_AddGroupMemberProgress_cn: "In Progress...",

    CMGMSG_AddGroupMemberFail_ko: "멤버 추가에 실패하였습니다.<br/><br/>",
    CMGMSG_AddGroupMemberFail_en: "Fail to add member.<br/><br/>",
    CMGMSG_AddGroupMemberFail_es: "Fail to add member.<br/><br/>",
    CMGMSG_AddGroupMemberFail_cn: "Fail to add member.<br/><br/>",

    CMGMSG_AddGroupMemberADFail1_ko: "AD에서 확인할 수 없는 유저를 제외하고 추가되었습니다.<br/>",
    CMGMSG_AddGroupMemberADFail1_en: "Member addition complete except below user(s)<br/>",
    CMGMSG_AddGroupMemberADFail1_es: "Member addition complete except below user(s)<br/>",
    CMGMSG_AddGroupMemberADFail1_cn: "Member addition complete except below user(s)<br/>",

    CMGMSG_AddGroupMemberADFail2_ko: "확인할 수 없는 유저는 다음과 같습니다.<br/>",
    CMGMSG_AddGroupMemberADFail2_en: "who doesn't exist at Active Directory.<br/>",
    CMGMSG_AddGroupMemberADFail2_es: "who doesn't exist at Active Directory.<br/>",
    CMGMSG_AddGroupMemberADFail2_cn: "who doesn't exist at Active Directory.<br/>",

    CMGMSG_AddGroupMemberSucceed_ko: "멤버가 추가되었습니다",
    CMGMSG_AddGroupMemberSucceed_en: "Addition Complete.",
    CMGMSG_AddGroupMemberSucceed_es: "Addition Complete.",
    CMGMSG_AddGroupMemberSucceed_cn: "Addition Complete.",

    // 연락처 메뉴
    ContactMenu_ko: "연락처",
    ContactMenu_en: "Contact",
    ContactMenu_es: "Contact",
    ContactMenu_cn: "联络方式",

    // Fax 선택항목 제목
    FaxFormToBoxName_ko: "Fax수신처",
    FaxFormToBoxName_en: "Fax Recipients",
    FaxFormToBoxName_es: "Fax Recipients",
    FaxFormToBoxName_cn: "Fax Recipients",

    // Fax 선택 조직도 제목
    FaxFormOrgChartTitle_ko: "Fax수신처 지정",
    FaxFormOrgChartTitle_en: "Select Fax Recipients",
    FaxFormOrgChartTitle_es: "Select Fax Recipients",
    FaxFormOrgChartTitle_cn: "Select Fax Recipients",

    AddressBook_ko: "개인주소록",
    AddressBook_en: "Personal Address Book",
    AddressBook_es: "Personal Address Book",
    AddressBook_cn: "个人地址簿",

    AddressBookGroup_ko: "개인주소록 그룹",
    AddressBookGroup_en: "Personal Address Book Group",
    AddressBookGroup_es: "Personal Address Book Group",
    AddressBookGroup_cn: "个人地址簿",

    TeamContacts_ko: "팀연락처",
    TeamContacts_en: "Team Contact",
    TeamContacts_es: "Team Contact",
    TeamContacts_cn: "团队联系方式",

    AddressBookTip_ko: "Outlook에 등록한 연락처를 보여줍니다.",
    AddressBookTip_en: "Show personal Contacts register Outlook.",
    AddressBookTip_es: "Show personal Contacts register Outlook.",
    AddressBookTip_cn: "显出Outlook中添加的联络方式。",

    // 선택항목박스
    ResultBox_ko: "선택항목",
    ResultBox_en: "Selected Items",
    ResultBox_es: "Selected Items",
    ResultBox_cn: "选项",

    Add_ko: "추가",
    Add_en: "Add",
    Add_es: "Add",
    Add_cn: "添加",

    AddTooltip_ko: "선택항목에 체크된 항목을 추가합니다.",
    AddTooltip_en: "Add checked items in Select Box.",
    AddTooltip_es: "Add checked items in Select Box.",
    AddTooltip_cn: "下拉框中添加所选择的项。",

    Remove_ko: "제거",
    Remove_en: "Remove",
    Remove_es: "Remove",
    Remove_cn: "移除",

    RemoveTooltip_ko: "선택항목에서 체크된 항목을 제거합니다.",
    RemoveTooltip_en: "Remove checked items in Select Box.",
    RemoveTooltip_es: "Remove checked items in Select Box.",
    RemoveTooltip_cn: "从下拉框中移除所选择的项。",

    RemoveAll_ko: "모두제거",
    RemoveAll_en: "Remove all",
    RemoveAll_es: "Remove all",
    RemoveAll_cn: "全部移除",

    RemoveAllTooltip_ko: "선택항목의 모든항목을 제거합니다.",
    RemoveAllTooltip_en: "Remove all items in Select Box.",
    RemoveAllTooltip_es: "Remove all items in Select Box.",
    RemoveAllTooltip_cn: "从下拉框中移除全部选项。",

    ToBox_ko: "받는사람",
    ToBox_en: "To",
    ToBox_es: "To",
    ToBox_cn: "收件人",

    ToAddTip_ko: "받는사람에 체크된 항목을 추가합니다.",
    ToAddTip_en: "Add checked items in To Box.",
    ToAddTip_es: "Add checked items in To Box.",
    ToAddTip_cn: "把收件人中添加选择的项。",

    ToRemoveTip_ko: "받는사람에 체크된 항목을 제거합니다.",
    ToRemoveTip_en: "Remove checked items in To Box.",
    ToRemoveTip_es: "Remove checked items in To Box.",
    ToRemoveTip_cn: "从收件人中移除所选择的项。",

    ToRemoveAllTip_ko: "받는사람의 모든항목을 제거합니다.",
    ToRemoveAllTip_en: "Remove all items in To Box.",
    ToRemoveAllTip_es: "Remove all items in To Box.",
    ToRemoveAllTip_cn: "从收件人中移除全部选择的项。",

    CcBox_ko: "참조",
    CcBox_en: "Cc",
    CcBox_es: "Cc",
    CcBox_cn: "抄送",

    CcAddTip_ko: "참조에 체크된 항목을 추가합니다.",
    CcAddTip_en: "Add checked items in Cc Box.",
    CcAddTip_es: "Add checked items in Cc Box.",
    CcAddTip_cn: "把抄送中添加所选择的项。",

    CcRemoveTip_ko: "참조에 체크된 항목을 제거합니다.",
    CcRemoveTip_en: "Remove checked items in Cc Box.",
    CcRemoveTip_es: "Remove checked items in Cc Box.",
    CcRemoveTip_cn: "从抄送者去除选择的项。",

    CcRemoveAllTip_ko: "참조에 모든항목을 제거합니다.",
    CcRemoveAllTip_en: "Remove all items in Cc Box.",
    CcRemoveAllTip_es: "Remove all items in Cc Box.",
    CcRemoveAllTip_cn: "把全部抄送者从选项中去除。",

    BccBox_ko: "숨은참조",
    BccBox_en: "Bcc",
    BccBox_es: "Bcc",
    BccBox_cn: "密件抄送",

    BccAddTip_ko: "숨은참조에 체크된 항목을 추가합니다.",
    BccAddTip_en: "Add checked items in Bcc Box.",
    BccAddTip_es: "Add checked items in Bcc Box.",
    BccAddTip_cn: "把选择的项添加到密件抄送中。",

    BccRemoveTip_ko: "숨은참조에 체크된 항목을 제거합니다.",
    BccRemoveTip_en: "Remove checked items in Bcc Box.",
    BccRemoveTip_es: "Remove checked items in Bcc Box.",
    BccRemoveTip_cn: "从密件抄送中去除所选择的项。",

    BccRemoveAllTip_ko: "숨은참조에 모든항목을 제거합니다.",
    BccRemoveAllTip_en: "Remove all items in Bcc Box.",
    BccRemoveAllTip_es: "Remove all items in Bcc Box.",
    BccRemoveAllTip_cn: "从密件抄送中去除全部选项。",

    NoEmailUserAdd_ko: "메일주소 정보가 없거나 정확하지 않아 추가할 수 없습니다.<br/>",
    NoEmailUserAdd_en: "It cann't insert email of no information or incorrect.<br/>",
    NoEmailUserAdd_es: "It cann't insert email of no information or incorrect.<br/>",
    NoEmailUserAdd_cn: "邮件地址不正确，或者找不到相关信息，因此无法添加。<br/>",

    // 검색박스
    SearchBox_ko: "사내 성명/사번 검색",
    SearchBox_en: "Search by Name/EmpNo",
    SearchBox_es: "Search by Name/EmpNo",
    SearchBox_cn: "按姓名或者工号检索",

    SearchDept_ko: "부서 이름 검색",
    SearchDept_en: "Search by Dept Name",
    SearchDept_es: "Search by Dept Name",
    SearchDept_cn: "Search by Dept Name",

    NoUseSpecialMsg_ko: "특수문자는 사용할 수 없습니다.",
    NoUseSpecialMsg_en: "Do not use special character.",
    NoUseSpecialMsg_es: "Do not use special character.",
    NoUseSpecialMsg_cn: "不能使用特殊字符。",

    NoUseAlphaNumTwoWord_ko: "영문으로 검색할 때는 3자이상 입력하셔야 합니다.",
    NoUseAlphaNumTwoWord_en: "Please enter 3 character english search keyword.",
    NoUseAlphaNumTwoWord_es: "Please enter 3 character english search keyword.",
    NoUseAlphaNumTwoWord_cn: "用英文检索时，必须使用3个字以上的字符。",

    UseSearch_ko: "검색시 2자 이상 8자이하의 문자로 입력해주세요.",
    UseSearch_en: "Inputing text on a scale of 2 to 8.",
    UseSearch_es: "Inputing text on a scale of 2 to 8.",
    UseSearch_cn: "检索时,请使用2~8字以下的文字书写。",

    SearchResult_ko: "&nbsp;검색 결과",
    SearchResult_en: "&nbsp;Search Results",
    SearchResult_es: "&nbsp;Search Results",
    SearchResult_cn: "&nbsp;检索结果",

    // 버튼
    OkBtn_ko: "확인",
    OkBtn_en: "Confirm",
    OkBtn_es: "Confirm",
    OkBtn_cn: "确认",

    CancelBtn_ko: "취소",
    CancelBtn_en: "Cancel",
    CancelBtn_es: "Cancel",
    CancelBtn_cn: "取消",

    CloseBtn_ko: "닫기",
    CloseBtn_en: "Close",
    CloseBtn_es: "Close",
    CloseBtn_cn: "Close",

    // 기타
    IEOnlyMSG_ko: "IE만 지원되는 함수입니다.",
    IEOnlyMSG_en: "This function support IE only.",
    IEOnlyMSG_es: "This function support IE only.",
    IEOnlyMSG_cn: "This function support IE only.",

    InvalidAPPTYPE_ko: "appType의 지정이 잘못되었습니다.",
    InvalidAPPTYPE_en: "Invalid appType value.",
    InvalidAPPTYPE_es: "Invalid appType value.",
    InvalidAPPTYPE_cn: "Invalid appType value.",

    WrongAPPTYPE_ko: "Custom APP 조직도는 appType이 [user],[deptuser] 일 경우만 구현되었습니다.",
    WrongAPPTYPE_en: "CustomApp Orgchart implemented for [user] or [deptuser] appType.",
    WrongAPPTYPE_es: "CustomApp Orgchart implemented for [user] or [deptuser] appType.",
    WrongAPPTYPE_cn: "CustomApp Orgchart implemented for [user] or [deptuser] appType.",

    UnknownErrorMsg_ko: "알수 없는 오류가 발생했습니다.",
    UnknownErrorMsg_en: "Unknown Error.",
    UnknownErrorMsg_es: "Unknown Error.",
    UnknownErrorMsg_cn: "产生未知的错误。",

    WaitMsg_ko: "잠시만 기다려주십시오.",
    WaitMsg_en: "Please wait...",
    WaitMsg_es: "Please wait...",
    WaitMsg_cn: "稍等...",

    SKRelative_ko: "관계사",
    SKRelative_en: "Relative",
    SKRelative_es: "Relative",
    SKRelative_cn: "相关公司",

    LoadingMsg_ko: "불러오는 중...",
    LoadingMsg_en: "Now Loading...",
    LoadingMsg_es: "Now Loading...",
    LoadingMsg_cn: "加载中...",

    GroupIndividual_ko : "그룹별 개별선택",
	GroupIndividual_en: "Individual select for each group",
	GroupIndividual_es: "Individual select for each group",
	GroupIndividual_cn: "Individual select for each group",

	Addj_ko: "겸직",
	Addj_en: "Additional job",
	Addj_es: "Additional job",
	Addj_cn: "兼職",

	doc01_ko: "문서담당(정)",
	doc01_en: "Doc Mgr. Principal",
	doc01_es: "Doc Mgr. Principal",
	doc01_cn: "文档管理器(正)",

	doc02_ko: "문서담당(부)",
	doc02_en: "Doc Mgr. Deputy",
	doc02_es: "Doc Mgr. Deputy",
	doc02_cn: "文档管理器(副)",

    Deactive_ko: "비활성자포함",
	Deactive_en: "Include inactive users",
	Deactive_es: "Include inactive users",
	Deactive_cn: "包括非活动用户"

};