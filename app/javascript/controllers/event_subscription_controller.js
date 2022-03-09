import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { eventId: Number, currentUserId: Number }
  static targets = ["messages", "form"]

  connect() {
    // this.channel = consumer.subscriptions.create(
    //   { channel: "EventChannel", id: this.eventIdValue },
    //   { received: data => this.#insertMessageScrollDownAndResetForm(data) }
    //   )
    //   console.log(`Subscribed to the chatroom with the id ${this.eventIdValue}.`)

    this.channel = consumer.subscriptions.create(
      { channel: "EventChannel", id: this.eventIdValue },
      { received: data => {
        // turn data into element
        console.log(data)
        let outerDiv = document.createElement('div');
        outerDiv.innerHTML = data;
        let message = outerDiv.firstElementChild
        console.log(message)
        // get sender id, numbers
        let senderId = parseInt(message.dataset.senderId)
        console.log(senderId)
        // get current_user id, numbers
        let currentUserId = parseInt(this.currentUserIdValue);
        console.log(currentUserId)

        // update message classes for incoming message
        if (senderId !== currentUserId){
          message.classList.remove("text-end");
          message.classList.add("text-start");

          // message.firstElementChild.classList.remove("text-right");
          // message.firstElementChild.classList.add("text-left");
          console.log(message.firstElementChild)
          message.firstElementChild.parentNode.insertBefore(message.childNodes[5], message.childNodes[1]);
          message.firstElementChild.parentNode.insertBefore(message.childNodes[4], message.childNodes[2]);
          message.childNodes[7].firstElementChild.style.removeProperty("margin-left")
          message.childNodes[7].firstElementChild.classList.remove("pe-2")
          message.childNodes[7].firstElementChild.classList.add("ps-1")
        }

        // send the message
        this.#insertMessageScrollDownAndResetForm(message)
      }}
    )

    }

    #insertMessageScrollDownAndResetForm(data) {
      this.messagesTarget.insertAdjacentElement("beforeend", data)
      this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
      this.formTarget.reset()
    }

    disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }
}
