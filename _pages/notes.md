---
layout: page
title: notes
permalink: /notes/
description: personal notes during learning
types: [paper_reading, basic]
---

{% assign sorted_notes = site.notes | sort: "title" %}
{% for t in page.types %}
<table>
  <tr>
    <th>{{t}}</th>
  </tr>
  {% for note in sorted_notes %}
    {% if note.not_published %}
    {% else %}
    {% if note.note_type == t %}
        <tr>
            <td>
                <a href="{{ note.url | relative_url }}">{{ note.title }}</a>
            </td>
        </tr>
    {% endif %}
    {% endif %}
  {% endfor %}
</table>
{% endfor %}
