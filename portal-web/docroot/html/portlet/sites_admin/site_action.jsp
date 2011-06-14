<%--
/**
 * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/html/portlet/sites_admin/init.jsp" %>

<%
ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

Group group = (Group)row.getObject();
%>

<liferay-ui:icon-menu>
	<c:if test="<%= GroupPermissionUtil.contains(permissionChecker, group.getGroupId(), ActionKeys.UPDATE) %>">
		<portlet:renderURL var="editURL">
			<portlet:param name="struts_action" value="/sites_admin/edit_site" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="groupId" value="<%= String.valueOf(group.getGroupId()) %>" />
		</portlet:renderURL>

		<liferay-ui:icon
			image="edit"
			url="<%= editURL %>"
		/>
	</c:if>

	<%--<c:if test="<%= GroupPermissionUtil.contains(permissionChecker, group.getGroupId(), ActionKeys.PERMISSIONS) %>">
		<liferay-security:permissionsURL
			modelResource="<%= Group.class.getName() %>"
			modelResourceDescription="<%= group.getName() %>"
			resourcePrimKey="<%= String.valueOf(group.getGroupId()) %>"
			var="permissionsURL"
		/>

		<liferay-ui:icon
	   		image="permissions"
			url="<%= permissionsURL %>"
		/>
	</c:if>--%>

	<c:if test="<%= GroupPermissionUtil.contains(permissionChecker, group.getGroupId(), ActionKeys.MANAGE_LAYOUTS) %>">
		<portlet:renderURL var="managePagesURL">
			<portlet:param name="struts_action" value="/sites_admin/edit_layouts" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="groupId" value="<%= String.valueOf(group.getGroupId()) %>" />
		</portlet:renderURL>

		<liferay-ui:icon
			image="pages"
			message="manage-pages"
			url="<%= managePagesURL %>"
		/>
	</c:if>

	<c:if test="<%= GroupPermissionUtil.contains(permissionChecker, group.getGroupId(), ActionKeys.MANAGE_STAGING) || GroupPermissionUtil.contains(permissionChecker, group.getGroupId(), ActionKeys.UPDATE) %>">
		<portlet:renderURL var="editSettingsURL">
			<portlet:param name="struts_action" value="/enterprise_admin/edit_settings" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="groupId" value="<%= String.valueOf(group.getGroupId()) %>" />
		</portlet:renderURL>

		<liferay-ui:icon
			image="configuration"
			message="site-settings"
			url="<%= editSettingsURL %>"
		/>
	</c:if>

	<c:if test="<%= GroupPermissionUtil.contains(permissionChecker, group.getGroupId(), ActionKeys.ASSIGN_MEMBERS) %>">
		<portlet:renderURL var="assignMembersURL">
			<portlet:param name="struts_action" value="/sites_admin/edit_site_assignments" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="groupId" value="<%= String.valueOf(group.getGroupId()) %>" />
		</portlet:renderURL>

		<liferay-ui:icon
			image="assign"
			message="manage-memberships"
			url="<%= assignMembersURL %>"
		/>
	</c:if>

	<c:if test="<%= group.getPublicLayoutsPageCount() > 0 %>">
		<portlet:actionURL var="viewPublicPagesURL">
			<portlet:param name="struts_action" value="/sites_admin/page" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="groupId" value="<%= String.valueOf(group.getGroupId()) %>" />
			<portlet:param name="privateLayout" value="<%= Boolean.FALSE.toString() %>" />
		</portlet:actionURL>

		<liferay-ui:icon
			image="view"
			message="go-to-public-pages"
			target="_blank"
			url="<%= viewPublicPagesURL %>"
		/>
	</c:if>

	<c:if test="<%= group.getPrivateLayoutsPageCount() > 0 %>">
		<portlet:actionURL var="viewPrivatePagesURL">
			<portlet:param name="struts_action" value="/sites_admin/page" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="groupId" value="<%= String.valueOf(group.getGroupId()) %>" />
			<portlet:param name="privateLayout" value="<%= Boolean.TRUE.toString() %>" />
		</portlet:actionURL>

		<liferay-ui:icon
			image="view"
			message="go-to-private-pages"
			target="_blank"
			url="<%= viewPrivatePagesURL %>"
		/>
	</c:if>

	<c:if test="<%= (group.getType() == GroupConstants.TYPE_SITE_OPEN) || (group.getType() == GroupConstants.TYPE_SITE_RESTRICTED) %>">
		<portlet:actionURL var="leaveURL">
			<portlet:param name="struts_action" value="/sites_admin/edit_site_assignments" />
			<portlet:param name="<%= Constants.CMD %>" value="group_users" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="groupId" value="<%= String.valueOf(group.getGroupId()) %>" />
			<portlet:param name="removeUserIds" value="<%= String.valueOf(user.getUserId()) %>" />
		</portlet:actionURL>

		<liferay-ui:icon
			image="leave"
			url="<%= leaveURL %>"
		/>
	</c:if>

	<c:if test="<%= GroupPermissionUtil.contains(permissionChecker, group.getGroupId(), ActionKeys.UPDATE) %>">
		<portlet:actionURL var="activateURL">
			<portlet:param name="struts_action" value="/sites_admin/edit_site" />
			<portlet:param name="<%= Constants.CMD %>" value="<%= group.isActive() ? Constants.DEACTIVATE : Constants.RESTORE %>" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="groupId" value="<%= String.valueOf(group.getGroupId()) %>" />
		</portlet:actionURL>

		<c:choose>
			<c:when test="<%= group.isActive() %>">
				<liferay-ui:icon-deactivate url="<%= activateURL %>" />
			</c:when>
			<c:otherwise>
				<liferay-ui:icon
					image="activate"
					url="<%= activateURL %>"
				/>
			</c:otherwise>
		</c:choose>
	</c:if>


	<c:if test="<%= GroupPermissionUtil.contains(permissionChecker, group.getGroupId(), ActionKeys.DELETE) %>">
		<portlet:actionURL var="deleteURL">
			<portlet:param name="struts_action" value="/sites_admin/edit_site" />
			<portlet:param name="<%= Constants.CMD %>" value="<%= Constants.DELETE %>" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="groupId" value="<%= String.valueOf(group.getGroupId()) %>" />
		</portlet:actionURL>

		<liferay-ui:icon-delete url="<%= deleteURL %>" />
	</c:if>
</liferay-ui:icon-menu>