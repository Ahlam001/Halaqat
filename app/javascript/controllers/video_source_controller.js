// app/javascript/controllers/video_source_controller.js
import { Controller } from "@hotwired/stimulus"

// data-controller="video-source"
export default class extends Controller {
  static targets = ["kind", "youtube", "upload"]

  connect() { this.toggle() }

  toggle() {
    const k = this.kindTarget.value
    if (k === "youtube") {
      this.youtubeTarget.classList.remove("hidden")
      this.uploadTarget.classList.add("hidden")
    } else {
      this.youtubeTarget.classList.add("hidden")
      this.uploadTarget.classList.remove("hidden")
    }
  }
}
