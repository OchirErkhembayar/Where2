import { Controller } from "@hotwired/stimulus";
import $ from "jquery";
import "select2";
import 'select2/dist/css/select2.min.css';

export default class extends Controller {
  // ...
  connect() {
    // If you console.log(this.optionsValue), it will print out the following Object in your browser's JavaScript console: {width: 300}
    $(this.element).select2(this.optionsValue);
    $(this.element).select2({
      placeholder: "Select...",
      allowClear: true,
      width: "100%"
    });
  }
}
