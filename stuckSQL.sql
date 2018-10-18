/*
-----------------------------

-- stuck request
findings:

Request type: PCA (6)
Request #: 2947 (PCA #)
Current status: Approved (2)

*/


-- Show the approval list
SELECT 
	ard.id,
	ard.UserId,
	te.Fullname,
	ard.[Priority],
	arat.[Description] as actionTaken
FROM AuthorizationRequestDetail ard
inner join
	DS_Global..AuthorizationActionType arat
	on ard.AuthorizationActionTypeId = arat.Id
	and ard.AuthorizationRequestId = 28379
inner join
	tblUsers users
	on ard.UserId = users.UserID
inner join
	tblEmployee te
	on users.EmployeeID = te.EmployeeID
order by
	ard.Id asc
/*
-----------------------------
findings:

Request type: PCA (6)
Request ID #: 28379

Id		AuthorizationRequestId	UserId	Priority	ActionedByUserId	AuthorizationActionTypeId	IsNext
91085	28379					6		NULL		6					1 - created					0
91086	28379					7		-20			7					6 - notified				0
91087	28379					5		40			5					3 - approved				0
91088	28379					7		-50			7					6 - notified				0
91089	28379					39		-60			39					6 - notified				0
91090	28379					3		70			3					3 - approved				0
*/

-- check PCA Status
select 
	pca.Id,
	stat.[Description]
from pca
inner join
	DS_Global..PCAStatus stat
	on pca.StatusId = stat.Id
	and pca.Id = 2947

/*
-----------------------------
findings:

PCA #: 2947
Current status: Pending(2)

*/

-- flip the status from
-- PENDING to APPROVED
update pca
	set
		StatusId = (select Id from DS_Global..PCAStatus where [Description] = 'Approved' )
where
	Id = 2947
-------------------------------------------------------------------------------------------------------------------------------------------
-- Locate the AuthorizationRequestID (ID)
SELECT *
FROM AuthorizationRequest
WHERE AuthorizationRequestTypeId = 6
 AND AuthorizationRequestTYpePK = 8053

-- Show the approval list
SELECT *
FROM AuthorizationRequestDetail
WHERE authorizationREquestID = 55411



-- Back Step the EWA # one approval back
EXEC spReAuthorize 7805,5

select tblEmployee.employeeid, tblEmployee.fullname, tblEmployee.email, tblEmployee.[password] 
	from tblemployee
	inner join tblUsers
		on tblUsers.Employeeid = tblEmployee.employeeid
	where tblUsers.UserID = 21 -- plug the UserID here

------------------------------------------------------------------------------------------------------------------------------------------