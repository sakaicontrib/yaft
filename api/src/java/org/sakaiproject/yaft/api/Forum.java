package org.sakaiproject.yaft.api;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Stack;
import java.util.UUID;

import org.sakaiproject.site.api.Site;
import org.sakaiproject.site.api.ToolConfiguration;
import org.sakaiproject.site.cover.SiteService;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

public class Forum
{
	private String id = "";
	private String title = "";
	private String description = "";
	private int discussionCount = 0;
	private int messageCount = 0;
	private long lastMessageDate;
	private long start = -1L;
	private long end = -1L;
	private boolean lockedForWriting = false;
	private boolean lockedForReading = false;
	private String siteId = "";
	private String status = "READY";
	private String creatorId = "";
	private List<Discussion> discussions= new ArrayList<Discussion>();
	private String url = "";
	
	public Forum()
	{
		id = UUID.randomUUID().toString();
	}
	
	public void setId(String id)
	{
		this.id = id;
	}
	public String getId()
	{
		return id;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public String getTitle()
	{
		return title;
	}
	public void setDescription(String description)
	{
		this.description = description;
	}
	public String getDescription()
	{
		return description;
	}
	public void setDiscussionCount(int discussionCount)
	{
		this.discussionCount = discussionCount;
	}
	public int getDiscussionCount()
	{
		return discussionCount;
	}
	public void setSiteId(String siteId)
	{
		this.siteId = siteId;
		
		try
		{
			Site site = SiteService.getSite(siteId);
			ToolConfiguration tc = site.getToolForCommonId("sakai.yaft");
			url = "/portal/tool/" + tc.getId() + "/forums/" + id;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	public String getSiteId()
	{
		return siteId;
	}

	public void setDiscussions(List<Discussion> discussions)
	{
		this.discussions = discussions;
	}

	public List<Discussion> getDiscussions()
	{
		return discussions;
	}

	public String getUrl()
	{
		return url;
	}

	public void setMessageCount(int messageCount)
	{
		this.messageCount = messageCount;
	}

	public int getMessageCount()
	{
		return messageCount;
	}

	public void setLastMessageDate(long lastMessageDate)
	{
		this.lastMessageDate = lastMessageDate;
	}

	public long getLastMessageDate()
	{
		return lastMessageDate;
	}

	public void setCreatorId(String creatorId)
	{
		this.creatorId = creatorId;
	}

	public String getCreatorId()
	{
		return creatorId;
	}
	
	public Element toXml(Document doc,Stack stack)
	{
		Element forumElement = doc.createElement(XmlDefs.FORUM);

		if (stack.isEmpty())
		{
			doc.appendChild(forumElement);
		}
		else
		{
			((Element) stack.peek()).appendChild(forumElement);
		}

		//stack.push(forumElement);

		forumElement.setAttribute(XmlDefs.ID, id);
		forumElement.setAttribute(XmlDefs.LAST_MESSAGE_DATE, Long.toString(lastMessageDate));
		forumElement.setAttribute(XmlDefs.MESSAGE_COUNT, Integer.toString(messageCount));
		forumElement.setAttribute(XmlDefs.DISCUSSION_COUNT, Integer.toString(discussionCount));
		
		Element titleElement = doc.createElement(XmlDefs.TITLE);
		titleElement.setTextContent(title);
		forumElement.appendChild(titleElement);
		
		Element descriptionElement = doc.createElement(XmlDefs.DESCRIPTION);
		descriptionElement.setTextContent(description);
		forumElement.appendChild(descriptionElement);
		
		Element discussionsElement = doc.createElement(XmlDefs.DISCUSSIONS);
		forumElement.appendChild(discussionsElement);
		
		stack.push(discussionsElement);
		
		for(Discussion discussion : discussions)
			discussion.toXml(doc,stack);
		
		stack.pop();
		
		return forumElement;
	}

	public void fromXml(Element forumElement)
	{
		if(!forumElement.getTagName().equals(XmlDefs.FORUM))
		{
			return;
		}
		
		NodeList children = forumElement.getElementsByTagName(XmlDefs.TITLE);
		setTitle(children.item(0).getFirstChild().getTextContent());
		
		children = forumElement.getElementsByTagName(XmlDefs.DESCRIPTION);
		setDescription(children.item(0).getFirstChild().getTextContent());
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStart(long start)
	{
		this.start = start;
	}

	public long getStart()
	{
		return start;
	}

	public void setEnd(long end)
	{
		this.end = end;
	}

	public long getEnd()
	{
		return end;
	}

	public boolean isCurrent()
	{
		if(start == -1 || end == -1)
			return false;
		else
		{
			long currentDate = new Date().getTime();

			if(start <= currentDate && currentDate <= end)
				return true;
			else
				return false;
		}
	}

	public void setLockedForWriting(boolean lockedForWriting)
	{
		this.lockedForWriting = lockedForWriting;
	}
	
	public boolean isLockedForWriting()
	{
		return lockedForWriting;
	}

	public boolean isLockedForWritingAndUnavailable()
	{
		return lockedForWriting && !isCurrent();
	}

	public void setLockedForReading(boolean lockedForReading)
	{
		this.lockedForReading = lockedForReading;
	}

	public boolean isLockedForReading()
	{
		return lockedForReading;
	}
	
	public boolean isLockedForReadingAndUnavailable()
	{
		return lockedForReading && !isCurrent();
	}
}
