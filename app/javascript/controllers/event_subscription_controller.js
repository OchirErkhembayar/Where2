import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { eventId: Number }
  static targets = ["messages", "form"]

  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: "EventChannel", id: this.eventIdValue },
      { received: data => this.#insertMessageScrollDownAndResetForm(data) }
      )
      console.log(`Subscribed to the chatroom with the id ${this.eventIdValue}.`)
    }

    #insertMessageScrollDownAndResetForm(data) {
      this.messagesTarget.insertAdjacentHTML("beforeend", data)
      this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
      this.formTarget.reset()
    }
    disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }
}
