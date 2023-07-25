/*
Company: OptimaJet
Project: WF.Sample WorkflowEngine.NET
File: FillData.sql
*/

BEGIN TRANSACTION

INSERT dbo.Roles(Id, Name) VALUES ('8d378ebe-0666-46b3-b7ab-1a52480fd12a', N'Big Boss')
INSERT dbo.Roles(Id, Name) VALUES ('412174c2-0490-4101-a7b3-830de90bcaa0', N'Accountant')
INSERT dbo.Roles(Id, Name) VALUES ('71fffb5b-b707-4b3c-951c-c37fdfcc8dfb', N'User')

INSERT dbo.StructDivision(Id, Name, ParentId) VALUES ('f6e34bdf-b769-42dd-a2be-fee67faf9045', N'Head Group', NULL)
INSERT dbo.StructDivision(Id, Name, ParentId) VALUES ('b14f5d81-5b0d-4acc-92b8-27cbbe39086b', N'Group 1', 'f6e34bdf-b769-42dd-a2be-fee67faf9045')
INSERT dbo.StructDivision(Id, Name, ParentId) VALUES ('7e9fd972-c775-4c6b-9d91-47e9397bd2e6', N'Group 1.1', 'b14f5d81-5b0d-4acc-92b8-27cbbe39086b')
INSERT dbo.StructDivision(Id, Name, ParentId) VALUES ('dc195a4f-46f9-41b2-80d2-77ff9c6269b7', N'Group 1.2', 'b14f5d81-5b0d-4acc-92b8-27cbbe39086b')
INSERT dbo.StructDivision(Id, Name, ParentId) VALUES ('72d461b2-234b-40d6-b410-b261964ba291', N'Group 2', 'f6e34bdf-b769-42dd-a2be-fee67faf9045')
INSERT dbo.StructDivision(Id, Name, ParentId) VALUES ('c5dcc148-9c0c-45c4-8a68-901d99a26184', N'Group 2.2', '72d461b2-234b-40d6-b410-b261964ba291')
INSERT dbo.StructDivision(Id, Name, ParentId) VALUES ('bc21a482-28e7-4951-8177-e57813a70fc5', N'Group 2.1', '72d461b2-234b-40d6-b410-b261964ba291')


INSERT dbo.Employee(Id, Name, StructDivisionId, IsHead) VALUES ('81537e21-91c5-4811-a546-2dddff6bf409', N'Silviya', 'f6e34bdf-b769-42dd-a2be-fee67faf9045', 1)
INSERT dbo.Employee(Id, Name, StructDivisionId, IsHead) VALUES ('b0e6fd4c-2db9-4bb6-a62e-68b6b8999905', N'Margo', 'dc195a4f-46f9-41b2-80d2-77ff9c6269b7', 0)
INSERT dbo.Employee(Id, Name, StructDivisionId, IsHead) VALUES ('deb579f9-991c-4db9-a17d-bb1eccf2842c', N'Max', 'b14f5d81-5b0d-4acc-92b8-27cbbe39086b', 1)
INSERT dbo.Employee(Id, Name, StructDivisionId, IsHead) VALUES ('91f2b471-4a96-4ab7-a41a-ea4293703d16', N'John', '7e9fd972-c775-4c6b-9d91-47e9397bd2e6', 1)
INSERT dbo.Employee(Id, Name, StructDivisionId, IsHead) VALUES ('e41b48e3-c03d-484f-8764-1711248c4f8a', N'Maria', 'c5dcc148-9c0c-45c4-8a68-901d99a26184', 0)
INSERT dbo.Employee(Id, Name, StructDivisionId, IsHead) VALUES ('bbe686f8-8736-48a7-a886-2da25567f978', N'Mark', '7e9fd972-c775-4c6b-9d91-47e9397bd2e6', 0)

INSERT dbo.EmployeeRole(EmployeeId, RoleId) VALUES ('e41b48e3-c03d-484f-8764-1711248c4f8a', '412174c2-0490-4101-a7b3-830de90bcaa0')
INSERT dbo.EmployeeRole(EmployeeId, RoleId) VALUES ('e41b48e3-c03d-484f-8764-1711248c4f8a', '71fffb5b-b707-4b3c-951c-c37fdfcc8dfb')
INSERT dbo.EmployeeRole(EmployeeId, RoleId) VALUES ('bbe686f8-8736-48a7-a886-2da25567f978', '71fffb5b-b707-4b3c-951c-c37fdfcc8dfb')
INSERT dbo.EmployeeRole(EmployeeId, RoleId) VALUES ('81537e21-91c5-4811-a546-2dddff6bf409', '8d378ebe-0666-46b3-b7ab-1a52480fd12a')
INSERT dbo.EmployeeRole(EmployeeId, RoleId) VALUES ('81537e21-91c5-4811-a546-2dddff6bf409', '71fffb5b-b707-4b3c-951c-c37fdfcc8dfb')
INSERT dbo.EmployeeRole(EmployeeId, RoleId) VALUES ('b0e6fd4c-2db9-4bb6-a62e-68b6b8999905', '71fffb5b-b707-4b3c-951c-c37fdfcc8dfb')
INSERT dbo.EmployeeRole(EmployeeId, RoleId) VALUES ('deb579f9-991c-4db9-a17d-bb1eccf2842c', '71fffb5b-b707-4b3c-951c-c37fdfcc8dfb')
INSERT dbo.EmployeeRole(EmployeeId, RoleId) VALUES ('91f2b471-4a96-4ab7-a41a-ea4293703d16', '71fffb5b-b707-4b3c-951c-c37fdfcc8dfb')



EXEC(N'INSERT dbo.WorkflowScheme(Code, Scheme) VALUES (N''SimpleWF'', N''
<Process Name="SimpleWF" CanBeInlined="false" Tags="" LogEnabled="false">
  <Designer X="-110" Y="-60" />
  <Actors>
    <Actor Name="BigBoss" Rule="CheckRole" Value="Big Boss" />
    <Actor Name="Accountant" Rule="CheckRole" Value="Accountant" />
  </Actors>
  <Parameters>
    <Parameter Name="Comment" Type="String" Purpose="Temporary" />
    <Parameter Name="NewAmount" Type="Decimal" Purpose="Persistence" />
  </Parameters>
  <Commands>
    <Command Name="Approve">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="Rollback">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="Finalize">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="Reject">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="SetNewAmount">
      <InputParameters>
        <ParameterRef Name="NewAmount" IsRequired="false" DefaultValue="" NameRef="NewAmount" />
      </InputParameters>
    </Command>
  </Commands>
  <Timers>
    <Timer Name="SendToBigBoss" Type="Interval" Value="10minutes" NotOverrideIfExists="false" />
  </Timers>
  <Comments>
    <Comment Name="Comment" Alignment="left" Rotation="0" Width="168" BoldText="false" ItalicText="false" UnderlineText="false" LineThroughText="false" FontSize="14" Value="↑&#xA;&#xA;This is the Activity and this is the first key object which makes up the diagram.&#xA;It specifies the order in which Actions are performed in your process.">
      <Designer X="320" Y="460" Color="#020930" Hidden="false" />
    </Comment>
    <Comment Name="Comment" Alignment="center" Rotation="0" Width="139.7236328125" BoldText="false" ItalicText="false" UnderlineText="false" LineThroughText="false" FontSize="14" Value="↑&#xA;This Transition &#xA;is triggered by a timer.">
      <Designer X="820" Y="480" Color="#020930" Hidden="false" />
    </Comment>
    <Comment Name="Comment" Alignment="center" Rotation="0" Width="157" BoldText="false" ItalicText="false" UnderlineText="false" LineThroughText="false" FontSize="14" Value=" This Transition is &#xA;triggered by a command &#xA;with condition&#xA;↓">
      <Designer X="810" Y="300" Color="#020930" Hidden="false" />
    </Comment>
    <Comment Name="Comment" Alignment="right" Rotation="0" Width="271" BoldText="false" ItalicText="false" UnderlineText="false" LineThroughText="false" FontSize="14" Value="This is the Transition and this is the second key object a scheme comprises.&#xA;Transition always connects two Activities together, and controls the sequence of execution of your processes.&#xA;&#xA;↓">
      <Designer X="320" Y="280" Color="#020930" Hidden="false" />
    </Comment>
    <Comment Name="Comment_1" Alignment="center" Rotation="0" Width="121.0615234375" BoldText="false" ItalicText="false" UnderlineText="false" LineThroughText="false" FontSize="14" Value=" This Transition is &#xA;triggered otherwise&#xA;↓">
      <Designer X="620" Y="150" Color="#020930" Hidden="false" />
    </Comment>
  </Comments>
  <Activities>
    <Activity Name="VacationRequestCreated" State="VacationRequestCreated" IsInitial="true" IsFinal="false" IsForSetState="true" IsAutoSchemeUpdate="true">
      <Designer X="310" Y="390" Color="#27AE60" Hidden="false" />
    </Activity>
    <Activity Name="ManagerSigning" State="ManagerSigning" IsInitial="false" IsFinal="false" IsForSetState="true" IsAutoSchemeUpdate="true">
      <Implementation>
        <ActionRef Order="1" NameRef="CreatePayment">
          <ActionParameter><![CDATA[@Sum]]></ActionParameter>
        </ActionRef>
      </Implementation>
      <Designer X="650" Y="390" Hidden="false" />
    </Activity>
    <Activity Name="BigBossSigning" State="BigBossSigning" IsInitial="false" IsFinal="false" IsForSetState="true" IsAutoSchemeUpdate="true">
      <Designer X="990" Y="390" Hidden="false" />
    </Activity>
    <Activity Name="AccountingReview" State="AccountingReview" IsInitial="false" IsFinal="false" IsForSetState="true" IsAutoSchemeUpdate="true">
      <Designer X="990" Y="210" Hidden="false" />
    </Activity>
    <Activity Name="RequestApproved" State="RequestApproved" IsInitial="false" IsFinal="true" IsForSetState="true" IsAutoSchemeUpdate="true">
      <Implementation>
        <ActionRef Order="1" NameRef="PayPayment" />
      </Implementation>
      <Designer X="1330" Y="210" Hidden="false" />
    </Activity>
    <Activity Name="Canceled" State="Canceled" IsInitial="false" IsFinal="true" IsForSetState="true" IsAutoSchemeUpdate="true">
      <Implementation>
        <ActionRef Order="1" NameRef="CancelPayment" />
      </Implementation>
      <Designer X="1320" Y="540" Hidden="false" />
    </Activity>
    <Activity Name="BigBoss rejection" State="BigBoss rejection" IsInitial="false" IsFinal="false" IsForSetState="true" IsAutoSchemeUpdate="true">
      <Designer X="990" Y="540" Hidden="false" />
    </Activity>
    <Activity Name="Requester signing" State="Requester signing" IsInitial="false" IsFinal="false" IsForSetState="true" IsAutoSchemeUpdate="true">
      <Designer X="1260" Y="290" Hidden="false" />
    </Activity>
    <Activity Name="Setting new amount" State="Setting new amount" IsInitial="false" IsFinal="false" IsForSetState="false" IsAutoSchemeUpdate="true">
      <Implementation>
        <ActionRef Order="1" NameRef="SetNewPaymentAmount">
          <ActionParameter><![CDATA[@NewAmount]]></ActionParameter>
        </ActionRef>
      </Implementation>
      <Designer X="1260" Y="400" Hidden="false" />
    </Activity>
  </Activities>
  <Transitions>
    <Transition Name="ManagerSigning_Draft_1" To="BigBoss rejection" From="ManagerSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="677" Y="581" Hidden="false" />
    </Transition>
    <Transition Name="BigBossSigning_Activity_1_1" To="AccountingReview" From="BigBossSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="BigBoss" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="1015" Y="355" Hidden="false" />
    </Transition>
    <Transition Name="ManagerSigning_Approved_1" To="AccountingReview" From="ManagerSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Otherwise" />
      </Conditions>
      <Designer X="677" Y="226" Hidden="false" />
    </Transition>
    <Transition Name="ManagerSigning_BigBossSigning_1" To="BigBossSigning" From="ManagerSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Action" NameRef="CheckAmountMoreThen" ConditionInversion="false">
          <ActionParameter><![CDATA[1000]]></ActionParameter>
        </Condition>
      </Conditions>
      <Designer X="887" Y="384" Hidden="false" />
    </Transition>
    <Transition Name="Draft_ManagerSigning_1" To="ManagerSigning" From="VacationRequestCreated" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Author" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="560" Y="436" Hidden="false" />
    </Transition>
    <Transition Name="BigBossSigning_ManagerSigning_1" To="ManagerSigning" From="BigBossSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="BigBoss" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Rollback" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="888" Y="420" Hidden="false" />
    </Transition>
    <Transition Name="ManagerSigning_BigBossSigning_2" To="BigBossSigning" From="ManagerSigning" Classifier="NotSpecified" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Triggers>
        <Trigger Type="Timer" NameRef="SendToBigBoss" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="888" Y="455" Hidden="false" />
    </Transition>
    <Transition Name="Accountant_Activity_1_1" To="RequestApproved" From="AccountingReview" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Accountant" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Finalize" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer Hidden="false" />
    </Transition>
    <Transition Name="Accountant_ManagerSigning_1" To="ManagerSigning" From="AccountingReview" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Accountant" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Rollback" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="723" Y="265" Hidden="false" />
    </Transition>
    <Transition Name="ManagerSigning_VacationRequestCreated_1" To="VacationRequestCreated" From="ManagerSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Rollback" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="561.6317901611328" Y="404" Hidden="false" />
    </Transition>
    <Transition Name="BigBossSigning_BigBoss rejection_1" To="BigBoss rejection" From="BigBossSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="BigBoss" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="1018" Y="487" Hidden="false" />
    </Transition>
    <Transition Name="BigBoss rejection_Canceled_1" To="Canceled" From="BigBoss rejection" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="BigBoss" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Finalize" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer Hidden="false" />
    </Transition>
    <Transition Name="BigBoss rejection_ManagerSigning_1" To="ManagerSigning" From="BigBoss rejection" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="BigBoss" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Rollback" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="722" Y="510" Hidden="false" />
    </Transition>
    <Transition Name="BigBossSigning_Activity_1" To="Requester signing" From="BigBossSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="BigBoss" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="SetNewAmount" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="1081" Y="313" Hidden="false" />
    </Transition>
    <Transition Name="Requester signing_Activity_1" To="Setting new amount" From="Requester signing" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Author" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="1452.5" Y="372" Hidden="false" />
    </Transition>
    <Transition Name="Changing_BigBossSigning_1" To="BigBossSigning" From="Setting new amount" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Triggers>
        <Trigger Type="Auto" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer Hidden="false" />
    </Transition>
    <Transition Name="Requester signing_BigBossSigning_1" To="BigBossSigning" From="Requester signing" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Author" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Rollback" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="1126" Y="345" Hidden="false" />
    </Transition>
  </Transitions>
  <Localization>
    <Localize Type="State" IsDefault="True" Culture="en-US" ObjectName="ManagerSigning" Value="Manager signing" />
    <Localize Type="State" IsDefault="True" Culture="en-US" ObjectName="BigBossSigning" Value="BigBoss signing" />
    <Localize Type="Command" IsDefault="True" Culture="en-US" ObjectName="StartSigning" Value="Start signing" />
    <Localize Type="State" IsDefault="True" Culture="en-US" ObjectName="AccountingReview" Value="Accounting review" />
    <Localize Type="State" IsDefault="True" Culture="en-US" ObjectName="VacationRequestCreated" Value="Vacation request created" />
    <Localize Type="State" IsDefault="True" Culture="en-US" ObjectName="RequestApproved" Value="Request approved" />
  </Localization>
</Process>
'')')


COMMIT TRANSACTION