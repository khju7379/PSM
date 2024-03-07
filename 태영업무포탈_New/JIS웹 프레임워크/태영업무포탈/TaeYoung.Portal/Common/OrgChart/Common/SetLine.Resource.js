
Ext.BLANK_IMAGE_URL = 'Common/ext/resources/images/default/s.gif';

// 네임스페이스
Ext.namespace('GW.SetLine');

if(Ext.isIE6)
	var strSpace= ""; 
else
	var strSpace= "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

GW.SetLine.Resource = {
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

    Confirm_ko: "확인",
    Confirm_en: "Confirm",
    Confirm_es: "Confirm",
    Confirm_cn: "确认",

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

    // 조직도 제목
    OrgMapTitle_ko: "조직도",
    OrgMapTitle_en: "Organization Chart",
    OrgMapTitle_es: "Organization Chart",
    OrgMapTitle_cn: "组织图",

    // 그룹선택박스
    GroupCombo_ko: "그룹 선택",
    GroupCombo_en: "Select group",
    GroupCombo_es: "Select group",
    GroupCombo_cn: "选择群组",

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

    GroupName_ko: "그룹이름",
    GroupName_en: "Group name",
    GroupName_es: "Group name",
    GroupName_cn: "Group name",

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

    // 검색박스
    SearchBox_ko: "검색어를 입력하십시오.",
    SearchBox_en: "Please enter your search query.",
    SearchBox_es: "Please enter your search query.",
    SearchBox_cn: "請輸入您的搜索查詢。",

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

    // 기타
    UnknownErrorMsg_ko: "알수 없는 오류가 발생했습니다.",
    UnknownErrorMsg_en: "Unknown Error.",
    UnknownErrorMsg_es: "Unknown Error.",
    UnknownErrorMsg_cn: "产生未知的错误。",

    WaitMsg_ko: "잠시만 기다려주십시오.",
    WaitMsg_en: "Please wait...",
    WaitMsg_es: "Please wait...",
    WaitMsg_cn: "稍等...",

    SKRelative_ko: "SK 관계사",
    SKRelative_en: "SK Relative",
    SKRelative_es: "SK Relative",
    SKRelative_cn: "SK 相关公司",

    LoadingMsg_ko: "불러오는 중...",
    LoadingMsg_en: "Now Loading...",
    LoadingMsg_es: "Now Loading...",
    LoadingMsg_cn: "加载中...",

    /***************** 결재선 지정창 관련 *****************/
    GroupIndividual_ko: "그룹별 개별선택",
    GroupIndividual_en: "Individual select for each group",
    GroupIndividual_es: "Individual select for each group",
    GroupIndividual_cn: "集团",

    SetLine_ko: "결재선 지정",
    SetLine_en: "Select approval line",
    SetLine_es: "Select approval line",
    SetLine_cn: "指定审批栏",

    AppArchive_ko: "결재선 보관",
    AppArchive_en: "Save approval line",
    AppArchive_es: "Save approval line",
    AppArchive_cn: "审批栏的保管",

    AppLineName_ko: "결재선명",
    AppLineName_en: "Name of approval line",
    AppLineName_es: "Name of approval line",
    AppLineName_cn: "审批栏名称",

    // 버튼
    Save_ko: "저장",
    Save_en: "Save",
    Save_es: "Save",
    Save_cn: "保存",

    Delete_ko: "삭제",
    Delete_en: "Delete",
    Delete_es: "Delete",
    Delete_cn: "删除",

    Load_ko: "불러오기",
    Load_en: "Get",
    Load_es: "Get",
    Load_cn: "Get",

    Up_ko: "위로",
    Up_en: "Up",
    Up_es: "Up",
    Up_cn: "Up",

    Down_ko: "아래로",
    Down_en: "Down",
    Down_es: "Down",
    Down_cn: "Down",

    Register_ko: "등록",
    Register_en: "Register",
    Register_es: "Register",
    Register_cn: "登记",

    // 타이틀
    Approver_ko: "결재자",
    Approver_en: "Approved by",
    Approver_es: "Approved by",
    Approver_cn: "审批人",

    Agree_ko: "협조자",
    Agree_en: "Person for support",
    Agree_es: "Person for support",
    Agree_cn: "协助者",

    AfterDraft_ko: "기안 후",
    AfterDraft_en: "After draft",
    AfterDraft_es: "After draft",
    AfterDraft_cn: "起案后",

    AfterRev1_ko: "검토1 후",
    AfterRev1_en: "After 1st review",
    AfterRev1_es: "After 1st review",
    AfterRev1_cn: "审核1后",

    AfterRev2_ko: "검토2 후",
    AfterRev2_en: "After 2nd review",
    AfterRev2_es: "After 2nd review",
    AfterRev2_cn: "审核2后",

    AfterRev3_ko: "검토3 후",
    AfterRev3_en: "After 3rd review",
    AfterRev3_es: "After 3rd review",
    AfterRev3_cn: "审核3后",

    AfterRev4_ko: "검토4 후",
    AfterRev4_en: "After 4th review",
    AfterRev4_es: "After 4th review",
    AfterRev4_cn: "审核4后",

    AfterRev5_ko: "검토5 후",
    AfterRev5_en: "After 5th review",
    AfterRev5_es: "After 5th review",
    AfterRev5_cn: "审核5后",

    AfterRev6_ko: "검토6 후",
    AfterRev6_en: "After 6th review",
    AfterRev6_es: "After 6th review",
    AfterRev6_cn: "审核6后",

    LevelTitle_ko: "단계",
    LevelTitle_en: "Level",
    LevelTitle_es: "Level",
    LevelTitle_cn: "阶段",

    Send_ko: "수신처",
    Send_en: "Recipient",
    Send_es: "Recipient",
    Send_cn: "接收人",

    Copy_ko: "사본처",
    Copy_en: "Copied recipient",
    Copy_es: "Copied recipient",
    Copy_cn: "抄送人",

    Charger_ko: "담당자",
    Charger_en: "Person in charge",
    Charger_es: "Person in charge",
    Charger_cn: "接收担当",

    LastApprover_ko: "승인자",
    LastApprover_en: "승인자",
    LastApprover_es: "승인자",
    LastApprover_cn: "승인자",

    TeamMember_ko: "팀원",
    TeamMember_en: "Team member",
    TeamMember_es: "Team member",
    TeamMember_cn: "组员",

    TeamLeader_ko: "팀장",
    TeamLeader_en: "Team Leader",
    TeamLeader_es: "Team Leader",
    TeamLeader_cn: "组长",

    BeforeAgree_ko: "전 협조자",
    BeforeAgree_en: "Pre-Supporter",
    BeforeAgree_es: "Pre-Supporter",
    BeforeAgree_cn: "前协助者",

    AfterAgree_ko: "후 협조자",
    AfterAgree_en: "Post-Supporter",
    AfterAgree_es: "Post-Supporter",
    AfterAgree_cn: "后协助者",

    AppointApprovalMustAppointWriter_ko: "기안자가 지정되지않았습니다.<br>기안자를 지정하여주십시오",
    AppointApprovalMustAppointWriter_en: "Drafter not selected. Please select a drafter.",
    AppointApprovalMustAppointWriter_es: "Drafter not selected. Please select a drafter.",
    AppointApprovalMustAppointWriter_cn: "未指定起草人。请指定起草人。",

    AppointApprovalMustAppointSequence_ko: "검토자 지정이 잘못되었습니다.<br>순차적으로 지정하여주십시오.",
    AppointApprovalMustAppointSequence_en: "Invalid reviewer selection. Please select reviewer in sequential manner.",
    AppointApprovalMustAppointSequence_es: "Invalid reviewer selection. Please select reviewer in sequential manner.",
    AppointApprovalMustAppointSequence_cn: "审核人指定有误。请依次指定。",

    AppointApprovalMustAppointApprover_ko: "승인자가 지정되지않았습니다.<br>승인자를 지정하여주십시오.",
    AppointApprovalMustAppointApprover_en: "Person with approval right is not selected. Please select one.",
    AppointApprovalMustAppointApprover_es: "Person with approval right is not selected. Please select one.",
    AppointApprovalMustAppointApprover_cn: "没有指定批准人。请指定批准人。",

    AppointApprovalMaxAgree_ko: "협조자 지정은 {0}명까지만 가능합니다.<br>다시 지정하여 주십시오.",
    AppointApprovalMaxAgree_en: "Only {0} supporter can be set. Please select again.",
    AppointApprovalMaxAgree_es: "Only {0} supporter can be set. Please select again.",
    AppointApprovalMaxAgree_cn: "协助者最多只能指定{0}人。请重新指定。",

    AclArchiveRegisterMsg_ko: "'{0}'이름으로 현재 지정된 수신처/사본처를 보관하시겠습니까?<br>ex) 좋은 사례 : A_Project 관련 팀원(회사 공식용어 사용)<br>" + strSpace + "ex) 나쁜 사례 : 우리팀원(주관적용어 사용)",
    AclArchiveRegisterMsg_en: "Would you like to save receiver/copied receiver as '{0}'?",
    AclArchiveRegisterMsg_es: "Would you like to save receiver/copied receiver as '{0}'?",
    AclArchiveRegisterMsg_cn: "Would you like to save receiver/copied receiver as '{0}'?",

    AddGroupMsg_ko: "'{0}' 수신처/사본처 보관항목의 내용을 현재 수신처/사본처 항목으로 반영합니다. 계속 진행하시겠습니까?",
    AddGroupMsg_en: "'{0}' receiver/copied receiver will be changed. Do you want to process?",
    AddGroupMsg_es: "'{0}' receiver/copied receiver will be changed. Do you want to process?",
    AddGroupMsg_cn: "'{0}' receiver/copied receiver will be changed. Do you want to process?",

    ImpossibleChange_ko: "'{0}' 항목은 변경이 불가능 합니다",
    ImpossibleChange_en: "'{0}' can't be changed.",
    ImpossibleChange_es: "'{0}' can't be changed.",
    ImpossibleChange_cn: "'{0}' can't be changed.",

    ValidationCheck_ko: "'{0}'항목은 필수 입력사항입니다.",
    ValidationCheck_en: "'{0}' is mandatory.",
    ValidationCheck_es: "'{0}' is mandatory.",
    ValidationCheck_cn: "'{0}' is mandatory.",

    AppointApprovalCurrentApprover_ko: "'현결재자'정보는 변경이 불가능합니다.",
    AppointApprovalCurrentApprover_en: "Current Approver can't change.",
    AppointApprovalCurrentApprover_es: "Current Approver can't change.",
    AppointApprovalCurrentApprover_cn: "当前应当改变不了.",

    ApproverAddTooltip_ko: "{0}에 체크된 항목을 추가합니다.",
    ApproverAddTooltip_en: "The checked item will be added at {0}.",
    ApproverAddTooltip_es: "The checked item will be added at {0}.",
    ApproverAddTooltip_cn: "The checked item will be added at {0}.",

    ApproverGroupAddTooltip_ko: "{0}에 저장된 그룹명으로 추가합니다.",
    ApproverGroupAddTooltip_en: "{0} will be added as saved group name.",
    ApproverGroupAddTooltip_es: "{0} will be added as saved group name.",
    ApproverGroupAddTooltip_cn: "{0} will be added as saved group name.",

    ApproverRemoveTooltip_ko: "{0}에 체크된 항목을 제거합니다.",
    ApproverRemoveTooltip_en: "Checked items in {0} will be deleted.",
    ApproverRemoveTooltip_es: "Checked items in {0} will be deleted.",
    ApproverRemoveTooltip_cn: "Checked items in {0} will be deleted.",

    ApproverRemoveAllTooltip_ko: "{0}의 모든항목을 제거합니다.",
    ApproverRemoveAllTooltip_en: "All item in {0} will be deleted.",
    ApproverRemoveAllTooltip_es: "All item in {0} will be deleted.",
    ApproverRemoveAllTooltip_cn: "All item in {0} will be deleted.",

    ApproverUpTooltip_ko: "선택된 {0}를 위로 이동합니다.",
    ApproverUpTooltip_en: "Move up {0}.",
    ApproverUpTooltip_es: "Move up {0}.",
    ApproverUpTooltip_cn: "Move up {0}.",

    ApproverDownTooltip_ko: "선택된 {0}를 아래로 이동합니다.",
    ApproverDownTooltip_en: "Move down {0}.",
    ApproverDownTooltip_es: "Move down {0}.",
    ApproverDownTooltip_cn: "Move down {0}.",

    ApproverMaxMsg_ko: "{0}지정은 최대 {1}명까지만 가능합니다. 다시 지정하여 주십시오.",
    ApproverMaxMsg_en: "{0} is allowed to select maxium {1}. Please do it again.",
    ApproverMaxMsg_es: "{0} is allowed to select maxium {1}. Please do it again.",
    ApproverMaxMsg_cn: "{0} is allowed to select maxium {1}. Please do it again.",

    NoInfoAddMsg_ko: "의 정보가 없어서 추가할 수 없습니다.",
    NoInfoAddMsg_en: " information does not exist.",
    NoInfoAddMsg_es: " information does not exist.",
    NoInfoAddMsg_cn: " information does not exist.",

    OnlyOneSelectMsg_ko: "한명만 지정 가능합니다.",
    OnlyOneSelectMsg_en: "Only one can be selected.",
    OnlyOneSelectMsg_es: "Only one can be selected.",
    OnlyOneSelectMsg_cn: "Only one can be selected.",

    GroupAdd_ko: "그룹추가",
    GroupAdd_en: "Add group.",
    GroupAdd_es: "Add group.",
    GroupAdd_cn: "Add group.",

    ArchiveRegisterTooltip_ko: "현재 결재 정보를 등록 합니다.",
    ArchiveRegisterTooltip_en: "Save the approval info.",
    ArchiveRegisterTooltip_es: "Save the approval info.",
    ArchiveRegisterTooltip_cn: "Save the approval info.",

    ArchiveLoadTooltip_ko: "선택된 결재정보를 불러옵니다.",
    ArchiveLoadTooltip_en: "Retrieve selected approval info.",
    ArchiveLoadTooltip_es: "Retrieve selected approval info.",
    ArchiveLoadTooltip_cn: "Retrieve selected approval info.",

    ArchiveNoNameMsg_ko: "저장 할 결재선명을 입력하세요.",
    ArchiveNoNameMsg_en: "Please input approval line name to save.",
    ArchiveNoNameMsg_es: "Please input approval line name to save.",
    ArchiveNoNameMsg_cn: "Please input approval line name to save.",

    ArchiveValidationExaMsg_ko: "검토전 협조를 지정하면 검토자가 지정되어야 합니다.",
    ArchiveValidationExaMsg_en: "Reviewer should be selected if you want to select supporter before reviewer.",
    ArchiveValidationExaMsg_es: "Reviewer should be selected if you want to select supporter before reviewer.",
    ArchiveValidationExaMsg_cn: "Reviewer should be selected if you want to select supporter before reviewer.",

    ArchiveValidationNameMsg_ko: " 는 이미 결재선명으로 저장되어 있습니다.",
    ArchiveValidationNameMsg_en: " is already save as same name.",
    ArchiveValidationNameMsg_es: " is already save as same name.",
    ArchiveValidationNameMsg_cn: " is already save as same name.",

    ArchiveRemoveTooltip_ko: "삭제할 결재선을 선택하십시오.",
    ArchiveRemoveTooltip_en: "Please select the approval line to delete.",
    ArchiveRemoveTooltip_es: "Please select the approval line to delete.",
    ArchiveRemoveTooltip_cn: "Please select the approval line to delete.",

    ArchiveOneSelectMsg_ko: "하나의 결재선만 선택 가능합니다.",
    ArchiveOneSelectMsg_en: "Select only one approval line.",
    ArchiveOneSelectMsg_es: "Select only one approval line.",
    ArchiveOneSelectMsg_cn: "Select only one approval line.",

    ArchiveCompleteAppMsg_ko: "결재가 완료된 사용자가 있어 결재선을 불러올 수 없습니다.",
    ArchiveCompleteAppMsg_en: "Can't retrieve the approval line because of user of completing approval.",
    ArchiveCompleteAppMsg_es: "Can't retrieve the approval line because of user of completing approval.",
    ArchiveCompleteAppMsg_cn: "Can't retrieve the approval line because of user of completing approval.",

    ArchiveLoadMsg_ko: "불러올 결재선을 선택하십시오.",
    ArchiveLoadMsg_en: "Please select the approval line to retrieve.",
    ArchiveLoadMsg_es: "Please select the approval line to retrieve.",
    ArchiveLoadMsg_cn: "Please select the approval line to retrieve.",

    ArchiveUpdateMsg_ko: "같은 이름의 결재선이 이미 존재합니다. 수정하시겠습니까?",
    ArchiveUpdateMsg_en: "There is same name of approval line. Do you want to edit?",
    ArchiveUpdateMsg_es: "There is same name of approval line. Do you want to edit?",
    ArchiveUpdateMsg_cn: "There is same name of approval line. Do you want to edit?",

    ApproverCompleteNoChangeMsg_ko: "'기결재자'정보는 변경이 불가능합니다.",
    ApproverCompleteNoChangeMsg_en: "It can't edit info of approval officer had been approved.",
    ApproverCompleteNoChangeMsg_es: "It can't edit info of approval officer had been approved.",
    ApproverCompleteNoChangeMsg_cn: "It can't edit info of approval officer had been approved.",

    ApproverDrafterNoChangeMsg_ko: "대리작성된 문서이기 때문에 기안자를 변경할 수 없습니다.",
    ApproverDrafterNoChangeMsg_en: "Drafter can't be changed because this document is created by other person.",
    ApproverDrafterNoChangeMsg_es: "Drafter can't be changed because this document is created by other person.",
    ApproverDrafterNoChangeMsg_cn: "Drafter can't be changed because this document is created by other person.",

    SendReference_ko: "수신처 참조",
    SendReference_en: "Ref. Recipient",
    SendReference_es: "Ref. Recipient",
    SendReference_cn: "参照收件人",

    GroupName_ko: "그룹명",
    GroupName_en: "Group name",
    GroupName_es: "Group name",
    GroupName_cn: "Group name",

    ArchivedSend_ko: "저장된 수신처",
    ArchivedSend_en: "Saved receiver",
    ArchivedSend_es: "Saved receiver",
    ArchivedSend_cn: "Saved receiver",

    ArchivedCopy_ko: "저장된 사본처",
    ArchivedCopy_en: "Saved copied receiver",
    ArchivedCopy_es: "Saved copied receiver",
    ArchivedCopy_cn: "Saved copied receiver",

    AclArchiveAddTooltip_ko: "현재 수신처/사본처 정보를 저장 합니다.",
    AclArchiveAddTooltip_en: "Save the receiver/copied receiver info.",
    AclArchiveAddTooltip_es: "Save the receiver/copied receiver info.",
    AclArchiveAddTooltip_cn: "Save the receiver/copied receiver info.",

    AclGroupName_ko: "수신처/사본처 그룹명",
    AclGroupName_en: "receiver/copied receiver group name",
    AclGroupName_es: "receiver/copied receiver group name",
    AclGroupName_cn: "receiver/copied receiver group name",

    AclArchiveLoadTooltip_ko: "선택된 수신처/사본처 정보를 불러옵니다.",
    AclArchiveLoadTooltip_en: "Retrieve saved receiver/copied receiver info.",
    AclArchiveLoadTooltip_es: "Retrieve saved receiver/copied receiver info.",
    AclArchiveLoadTooltip_cn: "Retrieve saved receiver/copied receiver info.",

    AclArchiveAddMsg_ko: "저장 할 그룹명을 입력하세요.",
    AclArchiveAddMsg_en: "Please input group name to save.",
    AclArchiveAddMsg_es: "Please input group name to save.",
    AclArchiveAddMsg_cn: "Please input group name to save.",

    AclArchiveUpdateMsg_ko: "같은 이름의 수신처/사본처 그룹이 이미 존재합니다. 수정하시겠습니까?",
    AclArchiveUpdateMsg_en: "There is same group name of receiver/copied receiver. Do you want to edit?",
    AclArchiveUpdateMsg_es: "There is same group name of receiver/copied receiver. Do you want to edit?",
    AclArchiveUpdateMsg_cn: "There is same group name of receiver/copied receiver. Do you want to edit?",

    AclArchiveRemoveMsg_ko: "삭제할 그룹명을 선택하십시오.",
    AclArchiveRemoveMsg_en: "Please select the group name to delete.",
    AclArchiveRemoveMsg_es: "Please select the group name to delete.",
    AclArchiveRemoveMsg_cn: "Please select the group name to delete.",

    OnlyOneSelectGroupMsg_ko: "하나의 그룹만 선택 가능합니다.",
    OnlyOneSelectGroupMsg_en: "You can choose the only one group.",
    OnlyOneSelectGroupMsg_es: "You can choose the only one group.",
    OnlyOneSelectGroupMsg_cn: "You can choose the only one group.",

    AclArchiveLoadMsg_ko: "불러올 그룹명을 선택하십시오.",
    AclArchiveLoadMsg_en: "Please select the group name to retrieve.",
    AclArchiveLoadMsg_es: "Please select the group name to retrieve.",
    AclArchiveLoadMsg_cn: "Please select the group name to retrieve.",

    BeforeApproves_ko: "전검토자",
    BeforeApproves_en: "Pre-Approver",
    BeforeApproves_es: "Pre-Approver",
    BeforeApproves_cn: "前檢討者",

    BeforeAgrees_ko: "전협조자",
    BeforeAgrees_en: "Pre-Supporter",
    BeforeAgrees_es: "Pre-Supporter",
    BeforeAgrees_cn: "前协助者",

    AfterApproves_ko: "후검토자",
    AfterApproves_en: "Post-Approver",
    AfterApproves_es: "Post-Approver",
    AfterApproves_cn: "后檢討者",

    AfterAgrees_ko: "후협조자",
    AfterAgrees_en: "Post-Supporter",
    AfterAgrees_es: "Post-Supporter",
    AfterAgrees_cn: "后协助者",

    AppointApprovalIsLoadLineSend_ko: "'{0}' 수신처/사본처 보관 항목의 내용을 현재 수신처/사본처 항목으로 반영합니다. 계속 진행하시겠습니까?",
    AppointApprovalIsLoadLineSend_en: "It will be changed receiver/copied receiver info. Do you want to process?",
    AppointApprovalIsLoadLineSend_es: "It will be changed receiver/copied receiver info. Do you want to process?",
    AppointApprovalIsLoadLineSend_cn: "It will be changed receiver/copied receiver info. Do you want to process?",

    AclArchiveValidation_ko: "선택하신 수신처/사본처 결재선이 이미 존재합니다.",
    AclArchiveValidation_en: "There is same name of receiver/copied receiver.",
    AclArchiveValidation_es: "There is same name of receiver/copied receiver.",
    AclArchiveValidation_cn: "There is same name of receiver/copied receiver.",

    ApproveValidationCheckMsg_ko: "{0}님은 이미 '{1}'에 지정된 사용자 입니다.",
    ApproveValidationCheckMsg_en: "{0} is already selected at '{1}'.",
    ApproveValidationCheckMsg_es: "{0} is already selected at '{1}'.",
    ApproveValidationCheckMsg_cn: "{0} is already selected at '{1}'.",

    RemoveAppArchiveMsg_ko: "지정한 결재선을 삭제하였습니다.",
    RemoveAppArchiveMsg_en: "Delete the choosing approval line.",
    RemoveAppArchiveMsg_es: "Delete the choosing approval line.",
    RemoveAppArchiveMsg_cn: "Delete the choosing approval line.",

    EmptyAppArchiveMsg_ko: "빈 결재선을 저장 할 수 없습니다.",
    EmptyAppArchiveMsg_en: "Can't save the empty approval line.",
    EmptyAppArchiveMsg_es: "Can't save the empty approval line.",
    EmptyAppArchiveMsg_cn: "Can't save the empty approval line.",

    RemoveAppArchiveConfirmMsg_ko: "'{0}' 결재선 보관항목을 삭제하시겠습니까?",
    RemoveAppArchiveConfirmMsg_en: "Would you like to delete '{0}' approval line item?",
    RemoveAppArchiveConfirmMsg_es: "Would you like to delete '{0}' approval line item?",
    RemoveAppArchiveConfirmMsg_cn: "Would you like to delete '{0}' approval line item?",

    RemoveAclArchiveConfirmMsg_ko: "'{0}' 수신처/사본처 보관항목을 삭제하시겠습니까?",
    RemoveAclArchiveConfirmMsg_en: "Would you like to delete '{0}' receiver/copied receiver item?",
    RemoveAclArchiveConfirmMsg_es: "Would you like to delete '{0}' receiver/copied receiver item?",
    RemoveAclArchiveConfirmMsg_cn: "Would you like to delete '{0}' receiver/copied receiver item?",

    LoadAppArchiveConfirmMsg_ko: "'{0}'결재선 보관 항목의 내용을 현재 결재선 지정 항목으로 반영합니다. 계속 진행하시겠습니까?",
    LoadAppArchiveConfirmMsg_en: "'{0}' approval line will be changed. Do you want continue?",
    LoadAppArchiveConfirmMsg_es: "'{0}' approval line will be changed. Do you want continue?",
    LoadAppArchiveConfirmMsg_cn: "'{0}' approval line will be changed. Do you want continue?",

    AddAppArchiveConfirmMsg_ko: "'{0}'이름으로 현재 지정된 결재선을 보관하시겠습니까?",
    AddAppArchiveConfirmMsg_en: "Do you want to save '{0}' approval line?",
    AddAppArchiveConfirmMsg_es: "Do you want to save '{0}' approval line?",
    AddAppArchiveConfirmMsg_cn: "Do you want to save '{0}' approval line?",

    AddAclArchiveConfirmMsg_ko: "'{0}'이름으로 현재 지정된 수신처/사본처를 보관하시겠습니까?",
    AddAclArchiveConfirmMsg_en: "Do you want to save {0} receiver/copied receiver?",
    AddAclArchiveConfirmMsg_es: "Do you want to save {0} receiver/copied receiver?",
    AddAclArchiveConfirmMsg_cn: "Do you want to save {0} receiver/copied receiver?",

    LoadAppArchiveCompleteMsg_ko: "결재선 {0}을/를 불러왔습니다.",
    LoadAppArchiveCompleteMsg_en: "Retrieve {0} approval line.",
    LoadAppArchiveCompleteMsg_es: "Retrieve {0} approval line.",
    LoadAppArchiveCompleteMsg_cn: "Retrieve {0} approval line.",

    UpdateAppArchiveMsg_ko: "결재선을 수정하였습니다.",
    UpdateAppArchiveMsg_en: "Edit approval line.",
    UpdateAppArchiveMsg_es: "Edit approval line.",
    UpdateAppArchiveMsg_cn: "Edit approval line.",

    SelectOrgMsg_ko: "조직도 항목을 선택하십시오.",
    SelectOrgMsg_en: "Select the item from organization tree.",
    SelectOrgMsg_es: "Select the item from organization tree.",
    SelectOrgMsg_cn: "Select the item from organization tree.",

    SelectAclGroupMsg_ko: "수신처/사본처 그룹항목을 선택하십시오.",
    SelectAclGroupMsg_en: "Select the receiver/copied receiver group item.",
    SelectAclGroupMsg_es: "Select the receiver/copied receiver group item.",
    SelectAclGroupMsg_cn: "Select the receiver/copied receiver group item.",

    SelectSendArchiveMemberMsg_ko: "저장된 수신처 항목을 선택하십시오.",
    SelectSendArchiveMemberMsg_en: "Select the saved receiver info.",
    SelectSendArchiveMemberMsg_es: "Select the saved receiver info.",
    SelectSendArchiveMemberMsg_cn: "Select the saved receiver info.",

    SelectCopyArchiveMemberMsg_ko: "저장된 사본처 항목을 선택하십시오.",
    SelectCopyArchiveMemberMsg_en: "select the saved copied receiver info.",
    SelectCopyArchiveMemberMsg_es: "select the saved copied receiver info.",
    SelectCopyArchiveMemberMsg_cn: "select the saved copied receiver info.",

    AddAppArchiveMsg_ko: "결재선을 저장하였습니다.",
    AddAppArchiveMsg_en: "Save the approval line info.",
    AddAppArchiveMsg_es: "Save the approval line info.",
    AddAppArchiveMsg_cn: "Save the approval line info.",

    AclArchiveGroupValidationMsg_ko: "수신처/사본처 그룹은 중복 저장 하실수 없습니다.",
    AclArchiveGroupValidationMsg_en: "Receiver/copied receiver group name can't be saved as existing same name.",
    AclArchiveGroupValidationMsg_es: "Receiver/copied receiver group name can't be saved as existing same name.",
    AclArchiveGroupValidationMsg_cn: "Receiver/copied receiver group name can't be saved as existing same name.",

    ApproverNotSetGroupMsg_ko: "그룹은 결재자로 지정할 수가 없습니다.",
    ApproverNotSetGroupMsg_en: "Group can't be selected as approval officer.",
    ApproverNotSetGroupMsg_es: "Group can't be selected as approval officer.",
    ApproverNotSetGroupMsg_cn: "Group can't be selected as approval officer.",

    AgreeRemoveConfirmMsg_ko: "지정한 협조자도 같이 삭제됩니다. 계속하시겠습니까?",
    AgreeRemoveConfirmMsg_en: "Selected supporter info will be deleted at the same time. Do you want to continue?",
    AgreeRemoveConfirmMsg_es: "Selected supporter info will be deleted at the same time. Do you want to continue?",
    AgreeRemoveConfirmMsg_cn: "Selected supporter info will be deleted at the same time. Do you want to continue?",

    AppointApprovalInternalCopy_ko: "사내사본처",
    AppointApprovalInternalCopy_en: "Internal Cc",
    AppointApprovalInternalCopy_es: "Internal Cc",
    AppointApprovalInternalCopy_cn: "公司内部抄送处",

    // CLX 관련 truefree 2009-09-24
    CLXChargerChargeDiv_ko: "담당분야 <font color='blue'>자료종류</font>",
    CLXChargerChargeDiv_en: "Charge <font color='blue'>Data Type</font>",
    CLXChargerChargeDiv_es: "Charge <font color='blue'>Data Type</font>",
    CLXChargerChargeDiv_cn: "Charge <font color='blue'>Data Type</font>",

    CLXChargerNameGrade_ko: "이름(사번)<font color='gray'>직위</font>",
    CLXChargerNameGrade_en: "Name(Emp No.) <font color='blue'>Grade</font>",
    CLXChargerNameGrade_es: "Name(Emp No.) <font color='blue'>Grade</font>",
    CLXChargerNameGrade_cn: "Name(Emp No.) <font color='blue'>Grade</font>",

    // ApprovaerAgree 관련
    ApproverAgreeTabDraft_ko: "기안({0})",
    ApproverAgreeTabDraft_en: "Draft({0})",
    ApproverAgreeTabDraft_es: "Draft({0})",
    ApproverAgreeTabDraft_cn: "Draft({0})",

    ApproverAgreeTabApp1_ko: "결재1({0})",
    ApproverAgreeTabApp1_en: "Approve 1({0})",
    ApproverAgreeTabApp1_es: "Approve 1({0})",
    ApproverAgreeTabApp1_cn: "Approve 1({0})",

    ApproverAgreeTabApp2_ko: "결재2({0})",
    ApproverAgreeTabApp2_en: "Approve 2({0})",
    ApproverAgreeTabApp2_es: "Approve 2({0})",
    ApproverAgreeTabApp2_cn: "Approve 2({0})",

    ApproverAgreeTabApp3_ko: "결재3({0})",
    ApproverAgreeTabApp3_en: "Approve 3({0})",
    ApproverAgreeTabApp3_es: "Approve 3({0})",
    ApproverAgreeTabApp3_cn: "Approve 3({0})",

    ApproverAgreeTabApp4_ko: "결재4({0})",
    ApproverAgreeTabApp4_en: "Approve 4({0})",
    ApproverAgreeTabApp4_es: "Approve 4({0})",
    ApproverAgreeTabApp4_cn: "Approve 4({0})",

    ApproverAgreeTabApp5_ko: "결재5({0})",
    ApproverAgreeTabApp5_en: "Approve 5({0})",
    ApproverAgreeTabApp5_es: "Approve 5({0})",
    ApproverAgreeTabApp5_cn: "Approve 5({0})",

    ApproverAgreeTabApp6_ko: "결재6({0})",
    ApproverAgreeTabApp6_en: "Approve 6({0})",
    ApproverAgreeTabApp6_es: "Approve 6({0})",
    ApproverAgreeTabApp6_cn: "Approve 6({0})",

    ApproverAgreeTabApp7_ko: "결재7({0})",
    ApproverAgreeTabApp7_en: "Approve 7({0})",
    ApproverAgreeTabApp7_es: "Approve 7({0})",
    ApproverAgreeTabApp7_cn: "Approve 7({0})",

    Addj_ko: "겸직",
    Addj_en: "Additional job",
    Addj_es: "Additional job",
    Addj_cn: "兼職",

    doc00_ko: "법인문서담당",
    doc00_en: "Company Doc Mgr.",
    doc00_es: "Company Doc Mgr.",
    doc00_cn: "文档管理器",

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
