package com.resustainability.reisp.model;

import java.time.LocalDateTime;
import java.util.List;

public class EMail {
	 private String from;           // Sender's email address
	    private String to;             // Recipient's email address (single)
	    private List<String> cc;       // CC recipients
	    private List<String> bcc;      // BCC recipients
	    private String subject;        // Email subject line
	    private String body;           // Email message body (plain text or HTML)
	    private boolean isHtml;        // Flag: true if body is HTML
	    private List<String> attachments; // File paths or Base64 encoded attachments
	    private LocalDateTime sentDate;   // Date and time email was sent
	    private String replyTo;        // Reply-to address

	    // --- Constructors ---
	    public EMail() {}

	    public EMail(String from, String to, String subject, String body) {
	        this.from = from;
	        this.to = to;
	        this.subject = subject;
	        this.body = body;
	        this.isHtml = false;
	    }

	    // --- Getters and Setters ---
	    public String getFrom() { return from; }
	    public void setFrom(String from) { this.from = from; }

	    public String getTo() { return to; }
	    public void setTo(String to) { this.to = to; }

	    public List<String> getCc() { return cc; }
	    public void setCc(List<String> cc) { this.cc = cc; }

	    public List<String> getBcc() { return bcc; }
	    public void setBcc(List<String> bcc) { this.bcc = bcc; }

	    public String getSubject() { return subject; }
	    public void setSubject(String subject) { this.subject = subject; }

	    public String getBody() { return body; }
	    public void setBody(String body) { this.body = body; }

	    public boolean isHtml() { return isHtml; }
	    public void setHtml(boolean isHtml) { this.isHtml = isHtml; }

	    public List<String> getAttachments() { return attachments; }
	    public void setAttachments(List<String> attachments) { this.attachments = attachments; }

	    public LocalDateTime getSentDate() { return sentDate; }
	    public void setSentDate(LocalDateTime sentDate) { this.sentDate = sentDate; }

	    public String getReplyTo() { return replyTo; }
	    public void setReplyTo(String replyTo) { this.replyTo = replyTo; }
}
