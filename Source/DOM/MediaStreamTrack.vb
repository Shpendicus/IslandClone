﻿'''<Summary>The MediaStreamTrack interface represents a single media track within a stream; typically, these are audio or video tracks, but other track types may exist as well.</Summary>
<DynamicInterface(GetType(EcmaScriptObject))>
Public Interface [MediaStreamTrack]
  '''<Summary>A string that may be used by the web application to provide a hint as to what type of content the track contains to guide how it should be treated by API consumers.</Summary>
  Property [contentHint] As String
  '''<Summary>A Boolean whose value of true if the track is enabled, that is allowed to render the media source stream; or false if it is disabled, that is not rendering the media source stream but silence and blackness. If the track has been disconnected, this value can be changed but has no more effect.</Summary>
  Property [enabled] As Boolean
  '''<Summary>Returns a DOMString containing a unique identifier (GUID) for the track; it is generated by the browser.</Summary>
  ReadOnly Property [id] As Integer
  '''<Summary>Returns a Boolean value which is true if the track is isolated; that is, the track cannot be accessed by the document that owns the MediaStreamTrack. This happens when the peerIdentity property is set, or if the track comes from a cross-origin source.</Summary>
  ReadOnly Property [isolated] As Boolean
  '''<Summary>Returns a DOMString set to "audio" if the track is an audio track and to "video", if it is a video track. It doesn't change if the track is deassociated from its source.</Summary>
  ReadOnly Property [kind] As String
  '''<Summary>Returns a DOMString containing a user agent-assigned label that identifies the track source, as in "internal microphone". The string may be left empty and is empty as long as no source has been connected. When the track is deassociated from its source, the label is not changed.</Summary>
  ReadOnly Property [label] As String
  '''<Summary>Returns a Boolean value indicating whether the track is unable to provide media data due to a technical issue.</Summary>
  ReadOnly Property [muted] As Boolean
  '''<Summary>Returns a Boolean value with a value of true if the track is readonly (such a video file source or a camera that settings can't be modified), false otherwise.</Summary>
  ReadOnly Property [readonly] As Dynamic
  '''<Summary>Returns an enumerated value giving the status of the track. This will be one of the following values:</Summary>
  ReadOnly Property [readyState] As String
End Interface