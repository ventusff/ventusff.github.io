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
  {% for note in site.notes %}
    {% if note.note_type == t %}
        <tr>
            <td>
                <a href="{{ note.url | relative_url }}">{{ note.title }}</a>
            </td>
        </tr>
    {% endif %}
  {% endfor %}
</table>
{% endfor %}
